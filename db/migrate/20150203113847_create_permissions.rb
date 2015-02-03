class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :user, index: true
      t.references :company, index: true
      t.string :subject_class
      t.integer :subject_id
      t.string :action

      t.timestamps null: false
    end
    add_foreign_key :permissions, :users
    add_foreign_key :permissions, :companies
  end
end
