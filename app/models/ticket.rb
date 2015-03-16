class Ticket < ActiveRecord::Base
  belongs_to :user
  has_many :ticket_replies

  enum priority: %w(низкий средний высокий)
  enum status: ['новая' , 'ответ послан' , 'в процессе' , 'закрыта']

  scope :client_tickets, -> (client) { where(user_id: client.users.ids) }

  def self.generate_code
    begin
      code = Array.new(8){rand(36).to_s(36)}.join.upcase
    end while Ticket.pluck(:code).include? code
    code
  end

  def notice!(client)
    User.customer_staff(client).each do |u|
      Notifications.notice(name, u.email, 'Новая заявка', client).deliver_later
    end
    Notifications.notice(name, user.email, 'Оповищение клиенту', client).deliver_later
    true
  end

  def reply_notice!(client)
    Notifications.notice(name, user.email, 'Ответ на заявку', client).deliver_later
    true
  end

end

