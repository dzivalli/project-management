class MilestoneTemplate < ActiveRecord::Base
  include Attributes

  belongs_to :owner, class_name: 'User'
  has_many :task_templates

  scope :select_fields, -> (id) { select(:name, :description).find(id) }
end
