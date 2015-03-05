class Client < ActiveRecord::Base
  belongs_to :main_company, class_name: 'Company'
  belongs_to :owner, class_name: 'User'
  has_many :users
  has_many :companies
  has_many :task_templates
  has_many :item_templates
  has_many :milestone_templates
  has_many :email_templates

  def copy_email_templates!
    self.email_templates = EmailTemplate.templates.dup
  end

end
