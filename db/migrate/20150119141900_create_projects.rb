class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description
      t.date :start_date
      t.date :due_date
      t.boolean :fixed_price
      t.float :fixed_rate
      t.float :hourly_rate
      t.string :status
      t.boolean :deleted
      t.text :notes
      t.integer :estimated_hours
      t.integer :progress
      t.references :company

      t.timestamps null: false
    end
  end
end
