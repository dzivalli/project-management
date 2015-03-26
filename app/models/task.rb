class Task < ActiveRecord::Base
  include Progressable, Noticable

  belongs_to :project
  belongs_to :milestone
  belongs_to :owner, class_name: 'User'

  has_and_belongs_to_many :users

  has_many :time_entries, dependent: :destroy

  validates :milestone_id, presence: true

  has_paper_trail

  scope :all_active, -> (user) { joins(:time_entries).joins(:users).where(users: {id: user}, time_entries: { status: 'active' }) }
  scope :for_user, -> (user) { joins(:users).where(users: {id: user}) }

  def active(user)
    TimeEntry.where(user: user, task: self, status: 'active').ids
  end
end
