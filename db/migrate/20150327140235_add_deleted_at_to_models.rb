class AddDeletedAtToModels < ActiveRecord::Migration
  def change
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at

    remove_column :invoices, :deleted, :boolean
    add_column :invoices, :deleted_at, :datetime
    add_index :invoices, :deleted_at

    remove_column :messages, :deleted, :boolean
    add_column :messages, :deleted_at, :datetime
    add_index :messages, :deleted_at

    remove_column :payments, :deleted, :boolean
    add_column :payments, :deleted_at, :datetime
    add_index :payments, :deleted_at

    remove_column :projects, :deleted, :boolean
    add_column :projects, :deleted_at, :datetime
    add_index :projects, :deleted_at

    add_column :milestones, :deleted_at, :datetime
    add_index :milestones, :deleted_at

    add_column :companies, :deleted_at, :datetime
    add_index :companies, :deleted_at

    add_column :clients, :deleted_at, :datetime
    add_index :clients, :deleted_at

    add_column :tickets, :deleted_at, :datetime
    add_index :tickets, :deleted_at

    add_column :ticket_replies, :deleted_at, :datetime
    add_index :ticket_replies, :deleted_at
  end
end
