class Setting < ActiveRecord::Base
  belongs_to :client

  scope :landing, -> { find_by(key: 'landing') }

  self.primary_key = :key

end
