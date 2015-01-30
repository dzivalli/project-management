class MilestonesController < ApplicationController
  include ProjectCommon

  def index
    @project = Project.includes(:milestones).find params[:project_id]
  end

  def new
    @milestone = Milestone.new
    @title = 'Новый этап'
    render layout: 'modal'
  end

  def create
    project = Project.find params[:project_id]
    project.milestones.build(permitted(params))
    if project.save
      redirect_to :back, notice: 'Этап был создан успешно'
    else
      redirect_to :back, alert: 'Произошла ошибка'
    end
  end

  def edit
    @milestone = Milestone.find params[:id]
    @title = 'Изменить данные'
    render layout: 'modal'
  end

  def update
    milestone = Milestone.find params[:id]
    milestone.update(permitted(params))
    if milestone.save
      redirect_to :back, notice: 'Данные были успешно обновленны'
    else
      redirect_to :back, alert: 'Произошла ошибка'
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

  private

  def permitted(params)
    params.require(:milestone).permit(:name, :start_date, :due_date, :description)
  end
end
