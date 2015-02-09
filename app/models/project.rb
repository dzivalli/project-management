class Project < ActiveRecord::Base
  belongs_to :company
  has_many :milestones
  has_many :tasks
  has_many :permissions
  has_many :attachments

  has_and_belongs_to_many :users

  validates_presence_of :title, :company, :start_date, :due_date, :description
  validates_length_of :title, maximum: 255

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
    tasks.joins(:time_entries).where(time_entries: {user: user, status: 'active'})
  end

end
