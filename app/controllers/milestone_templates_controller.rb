class MilestoneTemplatesController < ApplicationController
  def new
    @title = 'Новый шаблон этапа'
    @milestone_template = MilestoneTemplate.new
    render layout: 'modal'
  end

  def create
    milestone_template = MilestoneTemplate.new milestone_template_params.merge(owner: current_user)
    store do
      milestone_template.save
    end
    flash[:from] = 'milestone'
  end

  def edit
    @title = 'Изменить шаблон'
    @milestone_template = MilestoneTemplate.find params[:id]
    render 'new', layout: 'modal'
  end

  def update
    milestone_template = MilestoneTemplate.find params[:id]
    renew do
      milestone_template.update milestone_template_params
    end
    flash[:from] = 'milestone'
  end

  def destroy
    milestone_template = MilestoneTemplate.find params[:id]
    if milestone_template.destroy
      redirect_to :back, notice: 'Шаблон удален'
    end
    flash[:from] = 'milestone'
  end

  private

  def milestone_template_params
    params.require(:milestone_template).permit(:name, :description)
  end
end
