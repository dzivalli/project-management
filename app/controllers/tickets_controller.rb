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

  def show
    @tickets = Ticket.all
    @ticket = Ticket.find params[:id]
  end

  def destroy
  end

  private

  def ticket_params
    permitted = params.require(:ticket).permit(:subject, :priority, :body)
    permitted[:priority] = permitted[:priority].to_i
    permitted
  end
end
