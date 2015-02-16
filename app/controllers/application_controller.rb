class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, except: [:sessions]

  def user_for_paper_trail
    current_user.username if current_user
  end

  def store
    if yield
      redirect_to :back, notice: 'Объект был успешно создан'
    else
      redirect_to :back, alert: 'Произошла ошибка'
    end
  end

  def renew
    puts controller_name.inspect
    if yield
      redirect_to :back, notice: 'Данные были успешно изменены'
    else
      redirect_to :back, alert: 'Произошла ошибка'
    end
  end

  # def obj_name
  #   controller_name.singularize
  # end
end
