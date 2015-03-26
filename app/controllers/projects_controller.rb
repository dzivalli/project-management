class ProjectsController < ApplicationController
  include Projectable

  def index
    @projects = Project.client_projects(client, current_user)
  end

  def show
    @project = find_project { includes(:attachments, :tickets) }
    @logged_time = TimeEntry.logged_time_for(@project)
    @tasks = @project.tasks.assigned_to(current_user)
  end

  def new
    @users = client.users
    @project = Project.new
    @project.start_date = @project.due_date = Time.now.strftime("%d-%m-%Y")
    @companies = Company.customer_companies(client)
    @selected = params[:company_id] if params.key?(:company_id)
    @title = 'Новый проект'
    render layout: 'modal'
  end

  def create
    project = Project.new project_params
    store do
      (project.users = client.users.find(users_params)) && project.save && project.notice!(client)
    end
  end

  def edit
    @users = client.users
    @project = find_project
    @companies = Company.customer_companies(client)
    @title = 'Изменить данные'
    render 'new', layout: 'modal'
  end

  def update
    project = find_project
    renew do
      (project.users = client.users.find(users_params)) && project.update(project_params) && project.notice!(client)
    end
  end

  def destroy
    project = find_project
    if project.destroy
      redirect_to projects_path, notice: 'Проект был успешно удален'
    end
  end

  def team
    @project = find_project { includes(:users) }
  end



  def invoice
    @title = 'Создать счет за проект'
    @project = find_project
    render layout: 'modal'
  end

  def copy
    project = find_project
    @companies = Company.customer_companies(client)
    @users = client.users
    @title = 'Копировать проект'
    @project = project.dup
    @project.name += ' копия'
    render 'new', layout: 'modal'
  end

  private

  def project_params
    params.require(:project).permit(:action, :name, :description, :start_date,
                              :due_date, :fixed_price, :fixed_rate, :estimated_hours,
                              :hourly_rate, :progress, :company_id)
  end

  def users_params
    ids = params.require(:users).permit(id: [])[:id]
    ids.reject { |id| id.empty? }
  end

end
