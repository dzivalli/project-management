class Milestone < ActiveRecord::Base
  belongs_to :project
  has_many :tasks

  validates_presence_of :name, :start_date, :due_date


end
