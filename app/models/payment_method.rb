class PaymentMethod < ActiveRecord::Base
  has_many :payments

  scope :online, -> { find_by(name: 'Онлайн') }
end
