class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings, id: false do |t|
      t.string :key, null: false
      t.string :value
      t.references :client

      t.timestamps null: false
    end
    add_index :settings, :key, unique: true
    add_foreign_key :settings, :clients
  end
end
