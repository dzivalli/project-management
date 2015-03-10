class AddClientToPermission < ActiveRecord::Migration
  def change
    add_reference :permissions, :client, index: true

    add_foreign_key :permissions, :clients
  end
end
