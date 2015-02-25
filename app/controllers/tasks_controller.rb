class TasksController < ApplicationController
  include ProjectCommon
  # load_and_authorize_resource
  layout 'modal', only: [:new, :edit, :templates]

  def index
    @project = Project.includes(:tasks).find params[:project_id]
  end

  def new
    @task = Task.new(due_date: Time.now.strftime("%d-%m-%Y"))
    @title = 'Новая задача'
    @users = User.all
  end

  def create
    task =  if params.has_key?(:task_template)
      attrs = TaskTemplate.attributes_for(params[:task_template])
      Task.new attrs.merge(project_id: params[:project_id],
                           milestone_id: params[:milestone_id],
                           owner: current_user,
                           due_date: params[:due_date])
    else
      Task.new task_params.merge(project_id: params[:project_id], owner: current_user)
    end
    store do
      (task.users = User.find(users_params)) && task.save
    end
  end

  def edit
    @task = Task.find params[:id]
    @title = 'Измениить данные'
    @users = User.all
    render 'new'
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

  def templates
    @title = 'Вставить задачу из шаблона'
    @task_templates = TaskTemplate.all
    @users = User.all
    @milestones = Milestone.where(project_id: params[:project_id])
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :estimated_hours,
                                 :due_date, :milestone_id, :visible,
                                 :progress)
  end

  def users_params
    ids = if params.has_key?(:user_ids)
            params[:user_ids]
          else
            params.require(:users).permit(id: [])[:id]
          end
    ids.reject { |id| id.empty? }
  end
end
