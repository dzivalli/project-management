class Setting < ActiveRecord::Base
  belongs_to :client

  self.primary_key = :key

  def self.landing
    Setting.find_by(key: 'landing') || Setting.create!(key: 'landing', value: '')
  end
end
