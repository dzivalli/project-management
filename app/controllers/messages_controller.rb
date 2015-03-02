class MessagesController < ApplicationController
  def index
    @recipients = Message.recipients_for(current_user.id)
    @message = Message.new
    @roles = Role.all
    @users = User.customer_users(client)
  end

  def show
    @message = Message.new
    @recipients = Message.recipients_for(current_user.id)
    @messages = Message.by_user_and_recipient(current_user.id, params[:id])
  end

  def new
    @roles = Role.all
    @users = User.customer_users(client)
    @recipients = Message.recipients_for(current_user.id)
  end

  def create
    msg = Message.new message_params.merge(recipients: recipients_params, status: 'unread',
                                           user: current_user)
    store do
      msg.save
    end
  end

  def update
    msg = Message.new(message: params[:message], recipients: [params[:id].to_i],
                           user: current_user, status: 'unread')
    store do
      msg.save
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
    ids.reject { |id| id.empty? }
  end
end
