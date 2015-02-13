class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :recipients, array: true, null: false, default: []
      t.references :user
      t.text :message
      t.string :status
      t.string :attached_file
      t.date :date_received
      t.boolean :deleted

      t.timestamps null: false
    end

    add_foreign_key :messages, :users
  end
end
