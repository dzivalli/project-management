class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all
  end

  def new
    @title = 'Новая заявка'
    @ticket = Ticket.new
    render layout: 'modal'
  end

  def create
    ticket = Ticket.new ticket_params.merge(user: current_user, status: 'новая',
                                            code: Ticket.generate_code)
    store do
      ticket.save
    end
  end

  def edit
    @title = 'Изменить данные'
    @ticket = Ticket.find params[:id]
    render 'new', layout: 'modal'
  end

  def update
    ticket = Ticket.find params[:id]
    renew do
      ticket.update ticket_params
    end

  end

  def show
    @tickets = Ticket.all
    @ticket = Ticket.includes(:ticket_replies).find params[:id]
    @ticket_reply = TicketReply.new
  end

  def destroy
  end

  private

  def ticket_params
    permitted = params.require(:ticket).permit(:subject, :priority, :body, :status)
    permitted[:priority] = permitted[:priority].to_i
    permitted[:status] = permitted[:status].to_i if permitted.has_key?(:status)
    permitted
  end
end
