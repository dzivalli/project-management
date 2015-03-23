class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, except: [:sessions]
  before_action :check_client_plan!, except: [:unpaid]
  before_action :authorize_resource, except: [:unpaid]

  SKIP_CONTROLLERS = %w(Session Home Password)

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

  def check_client_plan!
    if current_user
      term = client.plan.term.months.to_i
      paid_on = client.paid_on || 5.years.ago
      if (client.plan.term != '999') && ((Time.now - paid_on.to_time) > term)
        redirect_to unpaid_path
      end
    end
  end

  def authorize_resource
    action = action_name.to_sym
    klass = controller_name.singularize
    klass = if klass.scan('_').any?
              klass.split('_').each do |k|
                k.capitalize
              end.join
            else
              klass.capitalize
            end
    authorize! action, klass.safe_constantize if klass && !SKIP_CONTROLLERS.include?(klass)
  end
end
