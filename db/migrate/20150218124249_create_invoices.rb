class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :reference_no
      t.references :company, index: true
      t.date :due_date
      t.text :notes
      t.float :tax, null: false, default: 0
      t.integer :discount

      # recurring
      t.boolean :recurring
      t.integer :recur_freq
      t.date :recur_start_date
      t.date :recur_end_date
      t.date :recur_next_date

      t.integer :status
      t.integer :archived
      t.date :sent_date
      t.boolean :deleted
      t.boolean :emailed
      t.boolean :visible
      t.boolean :viewed

      t.timestamps null: false
    end
    add_foreign_key :invoices, :companies
  end
end
