class AddMilestoneToTaskTemplate < ActiveRecord::Migration
  def change
    add_reference :task_templates, :milestone_template, index: true
    add_foreign_key :task_templates, :milestone_templates
  end
end
