class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :milestone
  belongs_to :added_by, class: 'User'

  has_and_belongs_to_many :users

  def self.new_or_upd_with_users(params, project_id, id = nil)
    users = params.delete(:users)
    users.reject! { |c| c.empty? }
    params.merge!(project_id: project_id)
    task = id ? Task.update(id, params) : Task.new(params)
    task.users = User.find(users)
    task
  end
end
