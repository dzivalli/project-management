class Company < ActiveRecord::Base
  has_many :users

  validates_presence_of :name, :address
  validates_uniqueness_of :name
  validates_length_of :name, :address, maximum: 255

end
