class AddPaidOnToClient < ActiveRecord::Migration
  def change
    add_column :clients, :paid_on, :date
  end
end
