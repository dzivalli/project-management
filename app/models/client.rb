class Client < ActiveRecord::Base
  belongs_to :main_company, class_name: 'Company'
  belongs_to :owner, class_name: 'User'
  has_many :users
  has_many :companies
  has_many :task_templates
  has_many :item_templates
  has_many :milestone_templates

end
