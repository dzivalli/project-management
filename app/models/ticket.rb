class Ticket < ActiveRecord::Base
  belongs_to :user
  has_many :ticket_replies

  enum priority: %w(низкий средний высокий)
  enum status: ['новая' , 'ответ послан' , 'в процессе' , 'закрыта']

  def self.generate_code
    begin
      code = Array.new(8){rand(36).to_s(36)}.join.upcase
    end while Ticket.pluck(:code).include? code
    code
  end

end

