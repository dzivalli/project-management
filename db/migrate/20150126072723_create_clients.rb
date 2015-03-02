class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.references :main_company
      t.references :owner

      t.timestamps null: false
    end
    add_index :clients, [:main_company_id, :owner_id]
  end
end
