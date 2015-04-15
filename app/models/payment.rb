class Payment < ActiveRecord::Base
  belongs_to :invoice, -> { with_deleted }
  belongs_to :company, -> { with_deleted }
  belongs_to :payment_method

  acts_as_paranoid

  scope :client_payments, -> (client) { where(company_id: client.companies.ids ) }

  def self.generate_trans
    begin
      trans = rand(100000..999999)
    end while Payment.pluck(:trans).include?(trans)
    trans
  end

end
