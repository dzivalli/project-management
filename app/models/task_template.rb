class TaskTemplate < ActiveRecord::Base
  include Templateble

  belongs_to :milestone_template
  belongs_to :user, -> { with_deleted }

  scope :select_fields, -> (id) { select(:name, :estimated_hours, :description, :visible).find(id) }

  def make_a_task(params, owner_id)
    permitted = params.permit(:project_id, :due_date, user_ids: [])
    users = User.find(permitted.delete(:user_ids))
    attrs = TaskTemplate.attributes_for(id)
    Task.create!(attrs.merge(permitted).merge(owner_id: owner_id, users: users))
  end
end
