module Attributes
  extend ActiveSupport::Concern

  class_methods do
    def attributes_for(id)
      select_fields(id).attributes.except('id')
    end
  end

end