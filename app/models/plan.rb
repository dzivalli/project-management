class Plan < ActiveRecord::Base
  has_many :clients

  def self.trial
    find_by(term: 1, cost: nil)
  end

  def self.unlimited
    find_by(term: 1, cost: nil)
  end
end
