class ProjectsController < ApplicationController

  def index
    @projects = Project.for_user(current_user)
  end

  def show
    @project = Project.find params[:id]
  end

  def new
    @users = User.all
    @project = Project.new
    @companies = Company.every
    @title = 'Новый проект'
    render layout: 'modal'
  end

  def create
    project = Project.new_or_upd_with_users(permitted(params), params[:id])
    if project.save
      redirect_to projects_path, notice: 'Проект был успешно создан'
    else
      redirect_to projects_path, alert: 'Произошла ошибка, повторите еще раз'
    end
  end

  def edit
    @users = User.all
    @project = Project.find params[:id]
    @companies = Company.every
    @title = 'Изменить данные'
    render 'new', layout: 'modal'
  end

  def update
    project = Project.new_or_upd_with_users(permitted(params), params[:id])
    if project.save
      redirect_to :back, notice: 'Данные были успешно изменены'
    else
      redirect_to :back, alert: 'Произошла ошибка, повторите еще раз'
    end
  end

  def destroy
    if Project.destroy params[:id]
      redirect_to projects_path, notice: 'Проект был успешно удален'
    end
  end

  def team
    @project = Project.includes(:users).find params[:id]
    authorize! :team, @project
  end

  def permissions
    @project = Project.find params[:id]
     # TODO create model method for:
    @permissions = Permission.for_client(@project).pluck(:subject_class, :action).flatten.uniq
  end

  def update_permissions
    permissions = params.slice(:milestone, :team, :task).keys
    Permission.update_for_client permissions, Project.find(params[:id])
    redirect_to :back, notice: 'Параметры доступа были обновленны'
  end

  private

  def permitted(params)
    params.require(:project).permit(:action, :title, :description, :start_date,
                              :due_date, :fixed_price, :fixed_rate, :estimated_hours,
                              :hourly_rate, :progress, :company_id,
                              users: [])
  end
end
