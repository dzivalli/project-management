class Plan < ActiveRecord::Base
  has_many :clients

  scope :trial, -> { find_by(term: 1, cost: nil) }
  scope :unlimited, -> { find_by(term: 999, cost: nil) }
  scope :paid, -> { where.not(cost: nil).order(:term) }

  def paid?
    cost != nil
  end

  def trial?
    (cost == nil) && (term == 1)
  end

  def unlimited?
    (cost == nil) && (term == 999)
  end

  def discount
    return 0 unless base_cost = Plan.paid.first.cost
    (100 - (cost / (base_cost * term / 100))).round
  end


end
