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
    task =  Task.new task_params.merge(project_id: params[:project_id], owner: current_user)
    store do
      (task.users = User.find(users_params)) && task.save
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
    renew do
      (task.users = User.find(users_params)) && task.update(task_params)
    end
  end

  def show
    @task = Task.find params[:id]
    @logged_time = TimeEntry.logged_time_for(@task)
  end

  def destroy
    task = Task.find params[:id]
    if task.destroy
      redirect_to project_tasks_path(id: params[:project_id]), notice: 'Задача удалена успешно'
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :estimated_hours,
                                 :due_date, :milestone_id, :visible,
                                 :progress)
  end

  def users_params
    ids = params.require(:users).permit(id: [])[:id]
    ids.reject! { |id| id.empty? }
  end
end
