class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description
      t.date :start
      t.date :due
      t.integer :estimated_hours
      t.boolean :fixed
      t.integer :rate
      t.references :company

      t.timestamps null: false
    end
  end
end
