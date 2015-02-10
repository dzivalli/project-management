class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :milestone
  belongs_to :added_by, class: 'User'

  has_and_belongs_to_many :users

  has_many :time_entries, dependent: :destroy

  has_paper_trail

  def active(user)
    TimeEntry.where(user: user, task: self, status: 'active').ids
  end
end
