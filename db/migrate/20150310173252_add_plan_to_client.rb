class AddPlanToClient < ActiveRecord::Migration
  def change
    add_reference :clients, :plan, index: true
    add_foreign_key :clients, :plans
  end
end
