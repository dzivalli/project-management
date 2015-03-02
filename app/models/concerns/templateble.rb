module Templateble
  extend ActiveSupport::Concern

  included do
    belongs_to :client

    scope :for_client, -> (client) { where(client: client) }
  end

  class_methods do
    def attributes_for(id)
      select_fields(id).attributes.except('id')
    end
  end

end