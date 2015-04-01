class Client < ActiveRecord::Base
  belongs_to :main_company, class_name: 'Company'
  belongs_to :owner, class_name: 'User'
  has_many :users, dependent: :destroy
  has_many :companies, dependent: :destroy
  has_many :task_templates, dependent: :destroy
  has_many :item_templates, dependent: :destroy
  has_many :milestone_templates, dependent: :destroy
  has_many :email_templates, dependent: :destroy
  has_many :permissions, dependent: :destroy
  belongs_to :plan

  acts_as_paranoid

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
    owner.touch(:confirmed_at)
    copy_email_templates!
    Notifications.client_notice(self, 'Завершение регистрации').deliver_later
  end

  def left
    term = plan.term * 30
    (term - (Date.today - paid_on)).to_i
  end

  def main_company_name
    if main_company
      main_company.name
    else
      'Ожидается регистрация компании'
    end
  end

  def owner_info
    if owner
      "#{owner.full_name} (#{owner.email})"
    else
      'Владелец компании не определен или удален'
    end
  end

  def plan_info
    if plan
      plan.name
    else
      'План удален'
    end
  end

  def users_count
    users.count > 0 ? users.count - 1 : 0
  end

  def companies_count
    companies.count > 0 ? users.count - 1 : 0
  end
end
