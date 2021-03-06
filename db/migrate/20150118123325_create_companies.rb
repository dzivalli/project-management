class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, null: false, default: ""
      t.string :email
      t.string :address, null: false, default: ""
      t.string :city
      t.string :website
      t.integer :phone
      t.references :contact
      t.references :client

      t.timestamps null: false
    end
  end
end
