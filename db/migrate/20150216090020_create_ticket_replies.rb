class CreateTicketReplies < ActiveRecord::Migration
  def change
    create_table :ticket_replies do |t|
      t.text :body
      t.references :ticket, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :ticket_replies, :tickets
    add_foreign_key :ticket_replies, :users
  end
end
