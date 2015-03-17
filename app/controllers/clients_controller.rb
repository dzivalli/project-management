class ClientsController < ApplicationController
  skip_before_action :authenticate_user!, except: [:index, :show]
  skip_before_action :authorize_resource, except: [:index, :show]

  def index
    @clients = Client.includes(:companies).all

  end

  def show
  end

  def new
    @client = Client.new
    @client.build_owner
  end

  def create
    if User.find_by_email(params[:user][:email])
      redirect_to :back, alert: 'Пользователь с таким email уже существует'
    else
      client = Client.new
      owner = client.build_owner(owner_params.merge!(client: client))
      owner.prepare
      if client.save
        Notifications.client_notice(client, 'Регистрация').deliver_later
        client.set_trial_plan!
        redirect_to new_user_session_path, notice: 'Письмо было успешно выслано'
      else
        redirect_to :back, alert: 'Произошла ошибка'
      end
    end
  end

  def edit
    @client = Client.find params[:id]
    if !@client.owner || (@client.owner.confirmation_token != params[:token])
      not_found
    end
    @client.build_main_company
  end

  def update
    client = Client.find params[:id]
    client.build_main_company(company_params.merge!(client: client))
    if client.save && client.owner.update(owner_params)
      client.after_registration(client)
      redirect_to new_user_session_path
    else
      render 'edit', alert: 'Произошла ошибка'
    end

  end

  private

  def owner_params
    params.require(:user).permit(:email, :full_name, :password, :password_confirmation)
  end

  def company_params
    params.require(:company).permit(:name, :email, :address, :phone, :city, :website)
  end
end
