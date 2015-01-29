class Project < ActiveRecord::Base
  belongs_to :company

  has_and_belongs_to_many :users

  validates_presence_of :title, :company, :start_date, :due_date, :description
  validates_length_of :title, maximum: 255


  def self.new_or_upd_with_users(params, id = nil)
    users = params.delete(:users)
    users.reject! { |c| c.empty? }
    project = id ? Project.update(id, params) : Project.new(params)
    project.users = User.find(users)
    project
  end
end
