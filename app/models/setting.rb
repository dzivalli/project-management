class Setting < ActiveRecord::Base
  belongs_to :client

  # scope :company, -> { where(key: 'company').pluck(:value) }

  self.primary_key = :key

end
