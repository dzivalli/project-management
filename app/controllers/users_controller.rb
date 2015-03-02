class UsersController < ApplicationController
  def index
    @users = User.customer_users(client).includes(:role, :company)
  end

  def new
    @selected = params[:company_id] if params.has_key?(:company_id)

    @user = User.new
    @roles = Role.all
    @companies = client.companies.all
    @title = 'Новый пользователь'
    render layout: 'modal'
  end

  def create
    user = User.new(permitted(params).merge(client: client))
    store do
      user.save
    end
  end

  def edit
    @user = User.customer_users(client).find_by_id params[:id]
    @roles = Role.all
    @companies = client.companies
    @title = 'Изменить данные'
    render 'new', layout: 'modal'
  end

  def password
    @user = User.find params[:id]
    # @companies = Company.all
    @title = 'Смена пароля'
    render 'new', layout: 'modal'
  end

  def update
    user = User.find params[:id]
    renew do
      user.update(permitted(params))
    end
  end

  def destroy
    user = User.customer_users(client).find params[:id]
    if user.destroy!
      redirect_to :back, notice: 'Пользователь был успешно удален'
    end
  end

  def primary
    company = Company.customer_companies(client).find params[:company_id]
    if company.update(contact: User.customer_users(client).find(params[:id]))
      redirect_to :back, notice: 'Основной контакт успешно установлен'
    end
  end

  private

  def permitted(params)
    params.require(:user).permit(:full_name, :email, :phone, :company_id,
                  :password, :password_confirmation, :role_id)
  end
end
