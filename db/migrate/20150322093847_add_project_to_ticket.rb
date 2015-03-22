class AddProjectToTicket < ActiveRecord::Migration
  def change
    add_reference :tickets, :project, index: true
    add_foreign_key :tickets, :projects
  end
end
