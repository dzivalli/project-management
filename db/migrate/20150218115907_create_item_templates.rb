class CreateItemTemplates < ActiveRecord::Migration
  def change
    create_table :item_templates do |t|
      t.string :name
      t.text :description
      t.integer :cost

      t.timestamps null: false
    end
  end
end
