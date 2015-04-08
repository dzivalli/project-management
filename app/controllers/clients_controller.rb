class ClientsController < ApplicationController
  skip_before_action :authenticate_user!, except: [:index, :show]
  skip_before_action :authorize_resource, except: [:index, :show]
  layout 'login', except: :index

  def index
    @clients = Client.includes(:companies).with_deleted
  end

  def show
  end

  def new
    @client = Client.new
    @client.build_owner
  end

  def create
    @client = Client.new client_params
    if @client.save_stage_1
      redirect_to new_user_session_path, notice: 'Письмо было успешно выслано'
    else
      flash[:alert] = @client.errors.full_messages
      render 'new'
    end
  end

  def edit
    @client = Client.find params[:id]
    @client.build_main_company if @client.checks?(params[:token])
  end

  def update
    @client = Client.find params[:id]

    if @client.save_stage_2(client_params)
      redirect_to new_user_session_path, notice: 'Компания успешно зарегистрирована'
    else
      flash[:alert] = @client.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    if params.key?(:destroy)
      client = Client.with_deleted.find params[:id]
      client.really_destroy!
      redirect_to :back, notice: 'Глобальный клиент был успешно удален'
    else
      client = Client.find params[:id]
      client.destroy
      redirect_to :back, notice: 'Глобальный клиент помечен, как удаленный'
    end
  end

  private

  def client_params
    params.require(:client).permit(main_company_attributes: [:name, :email, :address, :phone, :city, :website],
                  owner_attributes: [:id, :email, :full_name, :password, :password_confirmation, :phone])
  end
end
