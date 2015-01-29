class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @users = User.all
    @project = Project.new
    @companies = Company.every
    render layout: false
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
    @project = Project.find(params[:id])
    @companies = Company.every
    render 'new', layout: false
  end

  def update
    project = Project.new_or_upd_with_users(permitted(params), params[:id])
    if project.save
      redirect_to :back, notice: 'Проект был успешно создан'
    else
      redirect_to :back, alert: 'Произошла ошибка, повторите еще раз'
    end
  end

  def destroy
    if Project.destroy(params[:id])
      redirect_to projects_path, notice: 'Проект был успешно удален'
    end
  end

  def team
    @project = Project.find(params[:id])
    @team = @project.users
  end

  private

  def permitted(params)
    params.require(:project).permit(:action, :title, :description, :start_date,
                              :due_date, :fixed_price, :fixed_rate,
                              :hourly_rate, :progress, :company_id,
                              users: [])
  end
end
