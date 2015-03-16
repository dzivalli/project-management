class TasksController < ApplicationController
  include Projectable
  # load_and_authorize_resource
  layout 'modal', only: [:new, :edit, :templates]

  def index
    @project = find_project { includes(:tasks) }
  end

  def new
    @project = find_project
    @task = Task.new(due_date: Time.now.strftime("%d-%m-%Y"))
    @title = 'Новая задача'
    @users = client.users
  end

  def create
    task =  if params.has_key?(:task_template)
      attrs = TaskTemplate.attributes_for(params[:task_template])
      Task.new attrs.merge(milestone_id: params[:milestone_id],
                           owner: current_user,
                           due_date: params[:due_date])
    else
      Task.new task_params.merge(owner: current_user)
    end
    store do
      (task.users = User.find(users_params)) && (find_project.tasks << task) && task.notice!(client)
    end
  end

  def edit
    @project = find_project
    @task = @project.tasks.find params[:id]
    @title = 'Измениить данные'
    @users = client.users
    render 'new'
  end

  def update
    task = find_project.tasks.find params[:id]
    renew do
      (task.users = User.find(users_params)) && task.update(task_params) && task.notice!(client)
    end
  end

  def show
    @project = find_project
    @task = @project.tasks.find params[:id]
    @logged_time = TimeEntry.logged_time_for(@task)
  end

  def destroy
    task = find_project.tasks.find params[:id]
    if task.destroy
      redirect_to project_tasks_path(id: params[:project_id]), notice: 'Задача удалена успешно'
    end
  end

  def templates
    @title = 'Вставить задачу из шаблона'
    @task_templates = TaskTemplate.for_client(client)
    @users = client.users
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
