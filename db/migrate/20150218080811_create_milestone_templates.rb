class CreateMilestoneTemplates < ActiveRecord::Migration
  def change
    create_table :milestone_templates do |t|
      t.string :name
      t.text :description
      t.references :owner, index: true

      t.timestamps null: false
    end
  end
end
