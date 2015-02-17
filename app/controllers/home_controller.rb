class HomeController < ApplicationController
  def index
    @projects = Project.for_user(current_user)
    @versions = PaperTrail::Version.last(10)
    @message_count = Message.recipients_for(current_user.id).count
    @tickets = Ticket.all
  end
end
