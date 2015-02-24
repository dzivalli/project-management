class Invoice < ActiveRecord::Base
  belongs_to :company

  has_many :items
  has_many :payments

  enum status: %w(черновик)

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

end
