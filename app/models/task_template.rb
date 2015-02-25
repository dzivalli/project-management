class TaskTemplate < ActiveRecord::Base
  include Attributes

  belongs_to :owner, class_name: 'User'

  scope :select_fields, -> (id) { select(:name, :estimated_hours, :description, :visible).find(id) }
end
