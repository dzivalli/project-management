class Project < ActiveRecord::Base
  belongs_to :company
  has_many :milestones, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :time_entries, dependent: :destroy
  # TODO delete permissions after destroy
  has_many :permissions
  has_many :attachments, dependent: :destroy

  has_and_belongs_to_many :users

  has_paper_trail

  validates :name, presence: true, length: { maximum: 255 }
  validates :company, presence: true
  validates :start_date, presence: true
  validates :due_date, presence: true
  validates :start_date, presence: true
  validates :progress, numericality: true
           # less_than_or_equal_to: 100, greater_than_or_equal_to: 0


  # accepts_nested_attributes_for :milestones


  def self.for_user(user)
    if user.client?
      user.company.projects
    else
      Project.all
    end
  end

  def cost
    if fixed_price
      fixed_rate
    elsif estimated_hours
      hourly_rate * estimated_hours
    end
  end

  def active_tasks(user)
    time_entries.where(user: user, status: 'active')
  end

end
