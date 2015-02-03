class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
    @roles = Role.all
    @companies = Company.all
    @title = 'Новый пользователь'
    render layout: 'modal'
  end

  def create
    user = User.new(permitted(params))
    if user.save
      redirect_to users_path, notice: 'Пользователь был успешно создан'
    else
      # TODO active records errors i18
      redirect_to users_path, alert: "Ошибка#{user.errors.inspect}"
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
      redirect_to users_path, notice: 'Данные были успешно обновленны'
    else
      redirect_to users_path, alert: 'Произошла ошибка, попробуйте еще раз'
    end
  end

  def destroy
    user = User.find params[:id]
    if user.destroy!
      redirect_to users_path, notice: 'Пользователь был успешно удален'
    end
  end

  private

  def permitted(params)
    params.require(:user).permit(:full_name, :username, :email, :phone, :company_id,
                  :password, :password_confirmation, :role_id)
  end
end
