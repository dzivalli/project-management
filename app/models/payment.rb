class Payment < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :company
  belongs_to :payment_method

  scope :client_payments, -> (client) { where(company_id: client.companies.ids ) }

  MERCHANT_URL = 'http://test.robokassa.ru/Index.aspx'
  MERCHANT_LOGIN = 'project-system'
  MERCHANT_PASS_1 = 'rhjirfrfhnjirf1'
  MERCHANT_PASS_2 = ''
  SERVICES_URL = ''

  def generate_trans
    begin
      trans = rand(100000..999999)
    end while Payment.pluck(:trans).include?(trans)
    self.trans = trans
  end

  def pay_hash
    pay_desc = Hash.new
    pay_desc['mrh_url']   = MERCHANT_URL
    pay_desc['mrh_login'] = MERCHANT_LOGIN
    pay_desc['mrh_pass1'] = MERCHANT_PASS_1
    pay_desc['inv_id']    = invoice.reference_no
    pay_desc['inv_desc']  = invoice.notes
    pay_desc['out_summ']  = invoice.amount_due.to_s
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
end
