class TicketReply < ActiveRecord::Base
  belongs_to :ticket, -> { with_deleted }
  belongs_to :user, -> { with_deleted }

  acts_as_paranoid

  default_scope { order(created_at: :desc) }
end
