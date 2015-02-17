class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.references :project, index: true
      t.references :user, index: true
      t.references :task, index: true
      t.string :status

      t.timestamps null: false
    end
    add_foreign_key :time_entries, :projects
    add_foreign_key :time_entries, :users
    add_foreign_key :time_entries, :tasks
  end
end
