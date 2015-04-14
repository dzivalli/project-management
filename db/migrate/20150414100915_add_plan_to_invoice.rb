class AddPlanToInvoice < ActiveRecord::Migration
  def change
    add_reference :invoices, :plan, index: true
    add_foreign_key :invoices, :plans
  end
end
