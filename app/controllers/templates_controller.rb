class TemplatesController < ApplicationController
  def index
    @task_templates = TaskTemplate.all
    @milestone_templates = MilestoneTemplate.includes(:task_templates).all
    @item_templates = ItemTemplate.all
  end
end
