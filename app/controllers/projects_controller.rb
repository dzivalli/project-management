class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
    @companies = Company.every
    render layout: false
  end

  def create
    project = Project.new(permitted(params))
    if project.save
      redirect_to projects_path, notice: 'Проект был успешно создан'
    else
      redirect_to projects_path, alert: 'Произошла ошибка, повторите еще раз'
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def permitted(params)
    params.require(:project).permit(:title, :description, :start_date,
                              :due_date, :fixed_price, :fixed_rate,
                              :hourly_rate, :progress, :company_id)
  end
end
