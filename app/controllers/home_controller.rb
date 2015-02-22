class HomeController < ApplicationController
  def index
    @projects = Project.for_user(current_user)
    @versions = PaperTrail::Version.last(5)
    @message_count = Message.recipients_for(current_user.id).count
    @invoice_count = Invoice.count
    @tickets = Ticket.last(10)
    @payments = Payment.last(10)
  end
end
