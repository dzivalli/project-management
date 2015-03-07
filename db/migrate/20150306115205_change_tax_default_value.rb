class ChangeTaxDefaultValue < ActiveRecord::Migration
  def change
    change_column_default :invoices, :tax, 0
  end
end
