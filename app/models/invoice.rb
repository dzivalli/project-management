class Invoice < ActiveRecord::Base
  belongs_to :company

  has_many :items
  has_many :payments

  enum status: ['черновик', 'счет выставлен']

  scope :client_invoices, -> (client) { where(company: client.companies.ids) }

  def generate_reference
    last_id = Invoice.pluck(:id).last || 0
    number = self.id.to_s.length
    self.reference_no = "INV#{'0' * (5 - number)}#{last_id + 1}"
  end

  def sub_total
    items.inject(0) { |sum, item| sum + item.sum }
  end

  def total
    sum = sub_total.to_f
    (sum / 100 * tax) + sum
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
        if Notifications.notice_invoice(self, 'Выставление счета').deliver_now
          notice = 'Письмо отправленно успешно, счет выставлен'
          invoiced!
        end
      when 'remainder'
        if Notifications.notice_invoice(self, 'Повторная отправка').deliver_now
          notice = 'Повторное письмо отправленно успешно'
        end
    end
    notice
  end

end
