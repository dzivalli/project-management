class ProjectsController < ApplicationController

  def index
    # TODO check by role
    @projects = Project.client_projects(client)
  end

  def show
    @project = Project.includes(:attachments).client_projects(client).find params[:id]
    @logged_time = TimeEntry.logged_time_for(@project)
  end

  def new
    @users = client.users
    @project = Project.new
    @project.start_date = @project.due_date = Time.now.strftime("%d-%m-%Y")
    @companies = Company.customer_companies(client)
    @title = 'Новый проект'
    render layout: 'modal'
  end

  def create
    project = Project.new project_params
    store do
      (project.users = client.users.find(users_params)) && project.save
    end
  end

  def edit
    @users = client.users
    @project = Project.client_projects(client).find params[:id]
    @companies = Company.customer_companies(client)
    @title = 'Изменить данные'
    render 'new', layout: 'modal'
  end

  def update
    project = Project.client_projects(client).find params[:id]
    renew do
      (project.users = client.users.find(users_params)) && project.update(project_params)
    end
  end

  def destroy
    if Project.client_projects(client).destroy params[:id]
      redirect_to projects_path, notice: 'Проект был успешно удален'
    end
  end

  def team
    @project = Project.client_projects(client).includes(:users).find params[:id]
  end


  # TODO maybe new controller
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


  def invoice
    @title = 'Создать счет за проект'
    @project = Project.client_projects(client).find params[:id]
    render layout: 'modal'
  end

  def copy
    project = Project.client_projects(client).find(params[:id])
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
