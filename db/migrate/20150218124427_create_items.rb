class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :cost
      t.integer :quantity
      t.references :invoice, index: true

      t.timestamps null: false
    end
    add_foreign_key :items, :invoices
  end
end
