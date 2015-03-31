class Invoice < ActiveRecord::Base
  belongs_to :company, -> { with_deleted }

  has_many :items, dependent: :destroy
  has_many :payments

  acts_as_paranoid

  enum status: ['черновик', 'счет выставлен']

  scope :client_invoices, -> (client) { where(company: client.companies.ids) }


  MERCHANT_URL = 'http://test.robokassa.ru/Index.aspx'
  MERCHANT_LOGIN = 'project-system'
  MERCHANT_PASS_1 = 'rhjirfrfhnjirf1'
  MERCHANT_PASS_2 = ''
  SERVICES_URL = ''

  def self.from_project(params)
    company = Project.find(params[:project]).company
    invoice = Invoice.new company: company,
                          notes: "Создан из проекта ##{params[:project]}",
                          status: 'черновик'
    invoice.generate_reference!
    invoice.items.build name: params[:name],
                        description: params[:description],
                        cost: params[:cost].to_f,
                        quantity: 1
    invoice
  end

  def generate_reference!
    last_id = Invoice.pluck(:id).last || 0
    number = self.id.to_s.length
    self.reference_no = "INV#{'0' * (5 - number)}#{last_id + 1}"
  end

  def total
    items.inject(0) { |sum, item| sum + item.sum }
  end

  def amount_due
    # TODO add check if total bigger then amount of invoice
    paid = payments.pluck(:amount).inject(:+)
    if !paid
      total
    elsif paid > total
      # TODO overpaid put any flag?
      0
    else
      (total - paid).round(2)
    end
  end

  def paid
    total - amount_due
  end

  def payment_status
    if payments.none?
      'неоплачен'
    elsif amount_due == 0
      'оплачен'
    elsif amount_due > 0
      'оплачен частично'
    end

  end

  def invoiced!
    update(status: 'счет выставлен')
  end

  def send_email!(type)
    case type
      when 'invoiced'
        if Notifications.notice_invoice(self, 'Выставление счета').deliver_later
          notice = 'Письмо отправленно успешно, счет выставлен'
          invoiced!
        end
      when 'remainder'
        if Notifications.notice_invoice(self, 'Повторная отправка').deliver_later
          notice = 'Повторное письмо отправленно успешно'
        end
    end
    notice
  end


  def pay_hash
    pay_desc = Hash.new
    pay_desc['mrh_url']   = MERCHANT_URL
    pay_desc['mrh_login'] = MERCHANT_LOGIN
    pay_desc['mrh_pass1'] = MERCHANT_PASS_1
    pay_desc['inv_id']    = reference_no
    pay_desc['inv_desc']  = notes
    pay_desc['out_summ']  = amount_due.to_s
    pay_desc['shp_item']  = ''
    pay_desc['in_curr']   = "WMRM"
    pay_desc['culture']   = "ru"
    pay_desc['encoding']  = "utf-8"
    # crc
    pay_desc['crc'] = get_hash(pay_desc['mrh_login'],
                               pay_desc['out_summ'],
                               pay_desc['inv_id'],
                               pay_desc['mrh_pass1'])
    pay_desc
  end

  def get_hash(*s)
    Digest::MD5.hexdigest(s.join(':'))
  end

  def self.generate_from_plan(plan)


    invoice = Invoice.new due_date: Time.now + 1.week,
                          company: ''





    invoice.generate_reference!
  end

end
