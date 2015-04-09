class Company < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :permissions, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :payments, dependent: :destroy
  belongs_to :client, -> { with_deleted }
  belongs_to :contact, class_name: 'User'

  acts_as_paranoid

  has_paper_trail

  validates_presence_of :name, :address, :city
  validates_uniqueness_of :name
  validates_length_of :name, :address, maximum: 255

  scope :customer_companies, -> (client) { where(client: client).where.not(id: client.main_company) }

  def received_amount
    payments.inject(0) { |sum, payment| sum + payment.amount}
  end
end
