class Milestone < ActiveRecord::Base
  belongs_to :project
  has_many :tasks, dependent: :destroy

  validates_presence_of :name, :start_date, :due_date

  has_paper_trail

end
