class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, except: [:sessions]

  private

  def user_for_paper_trail
    current_user.id if current_user
  end

  def store(path = :back)
    if yield
      redirect_to path, notice: 'Объект был успешно создан'
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

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def client
    current_user.client
  end
end
