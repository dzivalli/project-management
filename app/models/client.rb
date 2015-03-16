class Client < ActiveRecord::Base
  belongs_to :main_company, class_name: 'Company'
  belongs_to :owner, class_name: 'User'
  has_many :users
  has_many :companies
  has_many :task_templates
  has_many :item_templates
  has_many :milestone_templates
  has_many :email_templates
  has_many :permissions
  belongs_to :plan

  def copy_email_templates!
    EmailTemplate.templates.each do |email|
      email_templates.create email.attributes.except('id', 'created_at', 'updated_at')
    end
  end

  def set_trial_plan!
    update(plan: Plan.trial, paid_on: Time.now)
  end

  def after_registration(client)
    owner.update(confirmed_at: Time.now, company: client.main_company)
    owner.admin!
    copy_email_templates!
    Notifications.client_notice(self, 'Завершение регистрации').deliver_later
  end

end
