class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :due_date
      t.references :project, index: true

      t.timestamps null: false
    end
    add_foreign_key :milestones, :projects
  end
end
