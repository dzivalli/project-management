class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :due_date
      t.references :project, index: true
      t.references :milestone, index: true
      t.boolean :visible
      t.integer :progress
      t.references :user, index: true
      t.boolean :auto_progress

      t.timestamps null: false
    end
    add_foreign_key :tasks, :projects
    add_foreign_key :tasks, :milestones
    add_foreign_key :tasks, :users
  end
end