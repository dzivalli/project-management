class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.date :start_time
      t.date :end_time
      t.references :project, index: true
      t.references :user, index: true
      t.references :task, index: true

      t.timestamps null: false
    end
    add_foreign_key :time_entries, :projects
    add_foreign_key :time_entries, :users
    add_foreign_key :time_entries, :tasks

    add_index :time_entries, [:project_id, :user_id, :task_id], unique: true
  end
end
