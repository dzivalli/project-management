class Setting < ActiveRecord::Base
  scope :company, -> { where(key: 'company').pluck(:value) }

  self.primary_key = :key

end
