class MilestonesController < ApplicationController
  include Projectable
  # load_and_authorize_resource
  layout 'modal', only: [:new, :edit, :templates]

  def index
    @project = project { includes(:milestones) }
  end

  def new
    @milestone = Milestone.new
    @milestone.start_date = @milestone.due_date = Time.now.strftime("%d-%m-%Y")
    @title = 'Новый этап'
  end

  def create
    milestone = if params.has_key?(:milestone_template)
                  attrs = MilestoneTemplate.attributes_for(params[:milestone_template])
                  tasks = TaskTemplate.where(milestone_template_id:  params[:milestone_template]).map do |task|
                    task.make_a_task(params, current_user.id)
                  end
                  Milestone.new attrs.merge(start_date: params[:start_date],
                                            due_date: params[:due_date])
                else
                  Milestone.new milestone_params
                end
    store do
      milestone.tasks = tasks if tasks
      project.milestones << milestone
    end
  end

  def edit
    @milestone = @project.milestones.find params[:id]
    @title = 'Изменить данные'
    render 'new'
  end

  def update
    milestone = project.milestones.find params[:id]
    renew do
      milestone.update milestone_params
    end
  end

  def destroy
    milestone = project.milestones.find params[:id]
    if milestone.destroy!
      redirect_to project_milestones_path(params[:project_id]), notice: 'Этап был успешно удален'
    end
  end

  def show
    @milestone = @project.milestones.find params[:id]
  end

  def templates
    @title = 'Добавить этап из шаблона'
    @users = client.users
    @milestone_templates = MilestoneTemplate.for_client(client)
  end

  private

  def milestone_params
    params.require(:milestone).permit(:name, :start_date, :due_date, :description)
  end
end
