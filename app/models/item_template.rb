class ItemTemplate < ActiveRecord::Base
  scope :select_fields, -> (id) { select(:name, :cost, :description).find(id) }

  def self.attributes_for(id)
    select_fields(id).attributes.except('id')
  end
end
