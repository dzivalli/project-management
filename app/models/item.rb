class Item < ActiveRecord::Base
  belongs_to :invoice

  def total
    cost * quantity
  end
end
