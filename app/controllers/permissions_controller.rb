class PermissionsController < ApplicationController
  include Projectable

  def index
    @users = User.customer_users(client)
    render 'users/index'
  end

  # TODO maybe new controller
  def new
    if params.key?(:project_id)
      @project = find_project
      # TODO create model method for:
      @permissions = Permission.for_client(@project).pluck(:subject_class, :action).flatten.uniq
    elsif params.key?(:user_id)
      @permissions = Permission.client_permissions(client).where(user_id: params[:user_id]).pluck(:action, :subject_class)
      @user = User.customer_users(client).find params[:user_id]
      render 'staff_permissions'
    end
  end

  def create
    if params.key?(:project_id)
      permissions = params.slice(:milestone, :team, :task).keys
      Permission.update_for_client permissions, find_project
      redirect_to :back, notice: 'Параметры доступа были обновленны'
    elsif params.key?(:user_id)
      renew do
        Permission.renew params, User.customer_users(client).find(params[:user_id]), client
      end
    end
  end
end
