class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :invoice, index: true
      t.references :company, index: true
      t.string :payer_email
      t.references :payment_method, index: true
      t.float :amount
      t.string :trans
      t.date :payment_date
      t.boolean :deleted
      t.text :notes

      t.timestamps null: false
    end
    add_foreign_key :payments, :invoices
    add_foreign_key :payments, :companies
    add_foreign_key :payments, :payment_methods
  end
end
