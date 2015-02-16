class HomeController < ApplicationController
  def index
    @projects = Project.for_user(current_user)
    @versions = PaperTrail::Version.last(10)
    @message_count = Message.recipients_count(current_user.id)
    @ticket_count = Ticket.count
  end
end
