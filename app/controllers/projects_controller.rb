class ProjectsController < ApplicationController

  def index
    @projects = Project.for_user(current_user)
  end

  def show
    @project = Project.includes(:attachments).find params[:id]
  end

  def new
    @users = User.all
    @roles = Role.all
    @project = Project.new
    @project.start_date = @project.due_date = Time.now.strftime("%d-%m-%Y")
    @companies = Company.every
    @title = 'Новый проект'
    render layout: 'modal'
  end

  def create
    project = Project.new project_params
    store do
      (project.users = User.find(users_params)) && project.save
    end
  end

  def edit
    @users = User.all
    @roles = Role.all
    @project = Project.find params[:id]
    @companies = Company.every
    @title = 'Изменить данные'
    render 'new', layout: 'modal'
  end

  def update
    project = Project.find(params[:id])
    renew do
      (project.users = User.find(users_params)) && project.update(project_params)
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

  private

  def project_params
    params.require(:project).permit(:action, :name, :description, :start_date,
                              :due_date, :fixed_price, :fixed_rate, :estimated_hours,
                              :hourly_rate, :progress, :company_id)
  end

  def users_params
    ids = params.require(:users).permit(id: [])[:id]
    ids.reject! { |id| id.empty? }
  end

end
