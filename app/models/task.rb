class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :milestone
  belongs_to :added_by, class: 'User'

  has_and_belongs_to_many :users

end
