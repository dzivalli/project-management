class Item < ActiveRecord::Base
  belongs_to :invoice

  validates :cost, presence: true, numericality: {greater_than: 0}
  validates :quantity, presence: true, numericality: {greater_than: 0}

  def sum
    cost * quantity
  end
end
