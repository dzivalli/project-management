class ItemTemplate < ActiveRecord::Base
  include Attributes

  scope :select_fields, -> (id) { select(:name, :cost, :description).find(id) }
end
