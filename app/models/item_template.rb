class ItemTemplate < ActiveRecord::Base
  include Templateble

  scope :select_fields, -> (id) { select(:name, :cost, :description).find(id) }
end
