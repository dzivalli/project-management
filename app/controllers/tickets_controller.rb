class TicketsController < ApplicationController
  layout 'modal', only: [:new, :edit]
  before_action :load_projects, only: [:new, :edit]

  def index
    @tickets = Ticket.includes(:project).client_tickets(client)
  end

  def new
    @title = 'Новая заявка'
    @ticket = Ticket.new
  end

  def create
    ticket = Ticket.new ticket_params.merge(user: current_user, status: 'новая',
                                            code: Ticket.generate_code)
    store do
      ticket.save && ticket.notice!(client)
    end
  end

  def edit
    @title = 'Изменить данные'
    @ticket = Ticket.client_tickets(client).find params[:id]
    render 'new'
  end

  def update
    ticket = Ticket.client_tickets(client).find params[:id]
    renew do
      ticket.update ticket_params
    end

  end

  def show
    @tickets = Ticket.client_tickets(client)
    @ticket = Ticket.includes(:ticket_replies).client_tickets(client).find params[:id]
    @ticket_reply = TicketReply.new
  end

  def destroy
    ticket = Ticket.client_tickets(client).find params[:id]
    if ticket.destroy
      redirect_to :back, notice: 'Заявка успешно удаленна'
    end
  end

  private

  def ticket_params
    permitted = params.require(:ticket).permit(:subject, :priority, :body, :status, :project_id)
    permitted[:priority] = permitted[:priority].to_i
    permitted[:status] = permitted[:status].to_i if permitted.has_key?(:status)
    permitted
  end

  def load_projects
    @projects = Project.client_projects(client, current_user).pluck(:name, :id)
  end
end
