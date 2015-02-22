class Payment < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :company
  belongs_to :payment_method

  def generate_trans
    begin
      trans = rand(100000..999999)
    end while Payment.pluck(:trans).include?(trans)
    self.trans = trans
  end
end
