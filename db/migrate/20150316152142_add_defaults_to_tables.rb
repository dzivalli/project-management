class AddDefaultsToTables < ActiveRecord::Migration
  def change
    change_column_default :tasks, :estimated_hours, 0
    change_column_default :item_templates, :cost, 0
    change_column_default :items, :cost, 0
    change_column_default :items, :quantity, 0
    change_column_default :plans, :term, 0
    change_column_default :projects, :estimated_hours, 0
    change_column_default :task_templates, :estimated_hours, 0
    change_column_default :task_templates, :estimated_hours, 0
  end
end
