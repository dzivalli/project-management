class Project < ActiveRecord::Base
  include Progressable, Noticable

  belongs_to :company
  has_many :milestones, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :time_entries, dependent: :destroy
  # TODO delete permissions after destroy
  has_many :attachments, dependent: :destroy

  has_and_belongs_to_many :users

  acts_as_paranoid

  has_paper_trail

  validates :name, presence: true, length: { maximum: 255 }
  validates :company, presence: true
  validates :start_date, presence: true
  validates :due_date, presence: true
  validates :start_date, presence: true
  validates :progress, numericality: true

  def self.client_projects(client, user)
    if user.admin? || user.root?
      Project.where(company: client.companies)
    elsif user.staff?
      Project.joins(:users).where(company: client.companies, users: {id: user.id})
    elsif user.customer?
      Project.where(company: user.company)
    end
  end

  def self.for_user(user)
    if user.customer?
      user.company.projects
    end
  end

  def cost
    if fixed_price
      fixed_rate
    elsif estimated_hours && hourly_rate
      hourly_rate * estimated_hours
    end
  end

  def active_tasks(user)
    time_entries.where(user: user, status: 'active')
  end

  def for_what
    if fixed_price
      'фиксированную цену проекта'
    else
      "за #{estimated_hours} часов"
    end
  end

  def overdue?
    due_date <= Time.now
  end

end
