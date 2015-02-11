class UsersController < ApplicationController
  def index
    @users = User.includes(:role, :company).all
  end

  def new
    @selected = params[:company_id] if params.has_key?(:company_id)

    @user = User.new
    @roles = Role.all
    @companies = Company.all
    @title = 'Новый пользователь'
    render layout: 'modal'
  end

  def create
    user = User.new(permitted(params))
    if user.save
      redirect_to :back, notice: 'Пользователь был успешно создан'
    else
      # TODO active records errors i18
      redirect_to :back, alert: "Ошибка#{user.errors.inspect}"
    end
  end

  def edit
    @user = User.find params[:id]
    @roles = Role.all
    @companies = Company.all
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
    if user.update(permitted(params))
      redirect_to :back, notice: 'Данные были успешно обновленны'
    else
      redirect_to :back, alert: 'Произошла ошибка, попробуйте еще раз'
    end
  end

  def destroy
    user = User.find params[:id]
    if user.destroy!
      redirect_to :back, notice: 'Пользователь был успешно удален'
    end
  end

  def primary
    company = Company.find params[:company_id]
    if company.update(contact: User.find(params[:id]))
      redirect_to :back, notice: 'Основной контакт успешно установлен'
    end
  end

  private

  def permitted(params)
    params.require(:user).permit(:full_name, :username, :email, :phone, :company_id,
                  :password, :password_confirmation, :role_id)
  end
end
