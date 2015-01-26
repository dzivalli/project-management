class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :milestone
  belongs_to :added_by, class: 'User'
end
