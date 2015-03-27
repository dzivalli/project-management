class HomeController < ApplicationController
  def index
    @projects = Project.client_projects(client, current_user)
    @versions = PaperTrail::Version.where(whodunnit: client.users.ids).order(created_at: :desc).last(5)
    @message_count = Message.recipients_for(current_user.id).count
    @invoice_count = Invoice.client_invoices(client).count
    @tickets = Ticket.client_tickets(client).for_user(current_user)
    @payments = Payment.client_payments(client)
    @tasks = Task.for_user(current_user) unless current_user.root?
  end

  def unpaid
    render plain: 'не уплачено'
  end
end
