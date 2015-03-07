class Milestone < ActiveRecord::Base
  include Progressable

  belongs_to :project
  has_many :tasks, dependent: :destroy

  validates_presence_of :name, :start_date, :due_date

  has_paper_trail

  def estimated_hours
    tasks.inject(0) { |sum, task| sum + task.estimated_hours }
  end

  def overdue?
    due_date <= Time.now
  end
end
