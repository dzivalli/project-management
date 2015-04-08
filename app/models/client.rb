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

  accepts_nested_attributes_for :main_company
  accepts_nested_attributes_for :owner

  def copy_email_templates!
    EmailTemplate.templates.each do |email|
      email_templates.create email.attributes.except('id', 'created_at', 'updated_at')
    end
  end

  def set_trial_plan!
    update(plan: Plan.trial, paid_on: Time.now)
  end

  def after_registration
    owner.update(confirmed_at: Time.now, company: main_company)
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
      deleted_owner = User.with_deleted.find(owner_id)
      if deleted_owner
        "#{deleted_owner.full_name} (#{deleted_owner.email}) (ПОМЕЧЕН НА УДАЛЕНИЕ)"
      else
        'Владелец компании не определен'
      end
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

  def save_stage_1
    owner.prepare
    if save
      owner.update client_id: id
      Notifications.client_notice(self, 'Регистрация').deliver_later
      set_trial_plan!
      true
    else
      false
    end
  end

  def save_stage_2(params)
    if !owner.confirmed? && update(params)
      main_company.update client_id: id
      after_registration
      true
    else
      false
    end
  end

  def checks?(token)
    if owner.confirmed? || !owner || (owner.confirmation_token != token)
      raise ActionController::RoutingError.new('Not Found')
    end
    true
  end
end
