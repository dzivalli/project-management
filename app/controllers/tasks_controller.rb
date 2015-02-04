class TasksController < ApplicationController
  include ProjectCommon
  load_and_authorize_resource

  def index
    @project = Project.includes(:tasks).find params[:project_id]
  end

  def new
    @task = @project.tasks.build
    @title = 'Новая задача'
    @milestones = @project.milestones
    @users = User.all
    render layout: 'modal'
  end

  def create
    task = Task.new_or_upd_with_users permitted(params), params[:project_id]
    if task.save
      redirect_to :back, notice: 'Задача создано успешно'
    else
      redirect_to :back, alert: 'Произошла ошибка'
    end
  end

  def edit
    @task = Task.find params[:id]
    @title = 'Измениить данные'
    @milestones = @project.milestones
    @users = User.all
    render 'new', layout: 'modal'
  end

  def update
    task = Task.new_or_upd_with_users permitted(params), params[:project_id],
                                      params[:id]
    if task.save
      redirect_to :back, notice: 'Задача обновленна успешно'
    else
      redirect_to :back, alert: 'Произошла ошибка'
    end
  end

  def show
    @task = Task.find params[:id]
  end

  def destroy
  end

  private

  def permitted(params)
    params.require(:task).permit(:name, :description, :estimated_hours,
                                 :due_date, :milestone_id, :visible,
                                 :progress, :added_by, users: [])
  end
end
