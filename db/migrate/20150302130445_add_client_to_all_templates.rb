class AddClientToAllTemplates < ActiveRecord::Migration
  def change
    add_reference :item_templates, :client, index: true
    add_reference :milestone_templates, :client, index: true
    add_reference :task_templates, :client, index: true

    add_foreign_key :item_templates, :clients
    add_foreign_key :milestone_templates, :clients
    add_foreign_key :task_templates, :clients

    remove_column :milestone_templates, :owner_id, :integer
    remove_column :task_templates, :owner_id, :integer
  end
end
