class CreateTaskTemplates < ActiveRecord::Migration
  def change
    create_table :task_templates do |t|
      t.string :name
      t.text :description
      t.integer :estimated_hours
      t.boolean :visible
      t.references :owner, index: true

      t.timestamps null: false
    end
  end
end
