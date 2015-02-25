class MilestonesController < ApplicationController
  include ProjectCommon
  # load_and_authorize_resource
  layout 'modal', only: [:new, :edit, :templates]

  def index
    @project = Project.includes(:milestones).find params[:project_id]
  end

  def new
    @milestone = Milestone.new
    @milestone.start_date = @milestone.due_date = Time.now.strftime("%d-%m-%Y")
    @title = 'Новый этап'
  end

  def create
    milestone = if params.has_key?(:milestone_template)
                  attrs = MilestoneTemplate.attributes_for(params[:milestone_template])
                  Milestone.new attrs.merge(project_id: params[:project_id],
                                            start_date: params[:start_date],
                                            due_date: params[:due_date])
                else
                  Milestone.new milestone_params.merge(project_id: params[:project_id])
                end
    store do
      milestone.save
    end
  end

  def edit
    @milestone = Milestone.find params[:id]
    @title = 'Изменить данные'
    render 'new'
  end

  def update
    milestone = Milestone.find params[:id]
    renew do
      milestone.update(permitted(params))
    end
  end

  def destroy
    milestone = Milestone.find params[:id]
    if milestone.destroy!
      redirect_to project_milestones_path(params[:project_id]), notice: 'Этап был успешно удален'
    end
  end

  def show
    @milestone = Milestone.find params[:id]
  end

  def templates
    @title = 'Добавить этап из шаблона'
    @milestone_templates = MilestoneTemplate.all
  end

  private

  def milestone_params
    params.require(:milestone).permit(:name, :start_date, :due_date, :description)
  end
end
