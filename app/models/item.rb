class Item < ActiveRecord::Base
  belongs_to :invoice

  validates :cost, presence: true, numericality: {greater_than: 0}
  validates :quantity, presence: true, numericality: {greater_than: 0}

  def sum
    cost * quantity
  end

  def self.from_plan!(plan)
    Item.create name: 'Оплата сервиса wookoo.ru',
                description: "Тарифный план: #{plan.name}",
                cost: plan.cost,
                quantity: 1
  end
end
