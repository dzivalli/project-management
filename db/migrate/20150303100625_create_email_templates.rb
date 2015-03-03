class CreateEmailTemplates < ActiveRecord::Migration
  def change
    create_table :email_templates do |t|
      t.string :name
      t.text :body
      t.integer :group
      t.references :client, index: true

      t.timestamps null: false
    end
    add_foreign_key :email_templates, :clients
  end
end
