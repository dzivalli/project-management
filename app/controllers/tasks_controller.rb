class TasksController < ApplicationController
  include ProjectCommon
  load_and_authorize_resource

  def index
    @project = Project.includes(:tasks).find params[:project_id]
  end

  def new
    @task = @project.tasks.build
    @title = 'Новая задача'
    @users = User.all
    render layout: 'modal'
  end

  def create
    task =  @project.tasks.build task_params
    if (task.users = User.find(users_params)) && task.save!
      redirect_to :back, notice: 'Задача создано успешно'
    else
      redirect_to :back, alert: 'Произошла ошибка'
    end
  end

  def edit
    @task = Task.find params[:id]
    @title = 'Измениить данные'
    @users = User.all
    render 'new', layout: 'modal'
  end

  def update
    task = Task.find params[:id]
    if (task.users = User.find(users_params)) && task.update!(task_params)
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

  def task_params
    params.require(:task).permit(:name, :description, :estimated_hours,
                                 :due_date, :milestone_id, :visible,
                                 :progress, :added_by)
  end

  def users_params
    ids = params.require(:users).permit(id: [])[:id]
    ids.reject! { |id| id.empty? }
  end
end
