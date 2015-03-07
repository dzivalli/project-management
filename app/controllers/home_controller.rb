class HomeController < ApplicationController
  def index
    @projects = Project.client_projects(client, current_user)
    @versions = PaperTrail::Version.where(whodunnit: client.users.ids).last(5)
    @message_count = Message.recipients_for(current_user.id).count
    @invoice_count = Invoice.client_invoices(client).count
    @tickets = Ticket.client_tickets(client)
    @payments = Payment.client_payments(client)
  end
end
