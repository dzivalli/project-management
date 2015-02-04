class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_to
      t.references :users
      t.text :message
      t.string :status
      t.string :attached_file
      t.date :date_received
      t.boolean :deleted

      t.timestamps null: false
    end
  end
end
