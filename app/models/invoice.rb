class Invoice < ActiveRecord::Base
  belongs_to :company

  has_many :items

  enum status: %w(черновик)

  def generate_reference
    last_id = Invoice.pluck(:id).last || 0
    number = self.id.to_s.length
    self.reference_no = "INV#{'0' * (5 - number)}#{last_id + 1}"
  end

  def sub_total
    items.inject(0) { |sum, item| sum + item.total }
  end

  def total
    sum = sub_total.to_f
    (sum / 100 * tax) + sum
  end

end
