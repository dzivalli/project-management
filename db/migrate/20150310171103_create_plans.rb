class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :term
      t.float :cost

      t.timestamps null: false
    end
  end
end
