class MessagesController < ApplicationController
  def index
    @recipients = Message.recipients_for(current_user.id)
    @message = Message.new
    @roles = Role.all
    @users = User.all
  end

  def show
    @message = Message.new
    @recipients = Message.recipients_for(current_user.id)
    @messages = Message.by_user_and_recipient(current_user.id, params[:id])
  end

  def new
    @message = Message.new
    @roles = Role.all
    @users = User.all
    @recipients = Message.recipients_for(current_user.id)
  end

  def create
    msg = Message.new message_params.merge(recipients: recipients_params, status: 'unread',
                                           user: current_user)
    if msg.save
      redirect_to :back, notice: 'Сообщение отправленно'
    else
      redirect_to :back, alert: 'Произошла ошибка'
    end
  end

  def destroy
  end

  private

  def message_params
    params.require(:message).permit(:message)
  end

  def recipients_params
    ids = params.require(:recipients).permit(id: [])[:id]
    ids.reject! { |id| id.empty? }
  end
end
