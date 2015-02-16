class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :subject
      t.string :code
      t.text :body
      t.integer :status
      t.integer :priority
      t.text :additional
      t.string :attachment
      t.references :user

      t.timestamps null: false
    end
  end
end
