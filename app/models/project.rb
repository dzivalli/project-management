class Project < ActiveRecord::Base
  belongs_to :company

  has_and_belongs_to_many :users

  validates_presence_of :title, :company, :start_date, :due_date, :description
  validates_length_of :title, maximum: 255

end
