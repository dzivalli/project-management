class TicketRepliesController < ApplicationController
  def create
    ticket = Ticket.client_tickets(client).find params[:ticket_id]
    ticket_reply = TicketReply.new ticket_reply_params.merge(user: current_user, ticket: ticket)
    store do
      ticket_reply.save && ticket.update(status: 'ответ послан') && ticket.reply_notice!(client)
    end
  end

  private

  def ticket_reply_params
    params.require(:ticket_reply).permit(:body)
  end
end
