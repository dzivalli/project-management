class Ticket < ActiveRecord::Base
  belongs_to :user, -> { with_deleted }
  belongs_to :project, -> { with_deleted }
  has_many :ticket_replies, dependent: :destroy

  acts_as_paranoid

  enum priority: %w(низкий средний высокий)
  enum status: ['новая' , 'ответ послан' , 'в процессе' , 'закрыта']

  scope :client_tickets, -> (client) { where(user_id: client.users.ids) }

  def self.for_user(user)
    if user.root?
      all
    else
      where(user: user)
    end
  end
  def self.generate_code
    begin
      code = Array.new(8){rand(36).to_s(36)}.join.upcase
    end while Ticket.pluck(:code).include? code
    code
  end

  def notice!(client)
    User.customer_staff(client).each do |u|
      Notifications.notice(subject, u.email, 'Новая заявка', client).deliver_later
    end
    Notifications.notice(subject, user.email, 'Оповищение клиенту', client).deliver_later
    true
  end

  def reply_notice!(client)
    Notifications.notice(subject, user.email, 'Ответ на заявку', client).deliver_later
    true
  end

end

