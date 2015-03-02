class Client < ActiveRecord::Base
  belongs_to :main_company, class_name: 'Company'
  belongs_to :owner, class_name: 'User'
  has_many :users
  has_many :companies

end
