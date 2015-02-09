class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file
      t.text :description
      t.references :project, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :attachments, :projects
    add_foreign_key :attachments, :users
  end
end
