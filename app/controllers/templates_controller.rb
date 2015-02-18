class TemplatesController < ApplicationController
  def index
    @task_templates = TaskTemplate.all
    @milestone_templates = MilestoneTemplate.all
    @item_templates = ItemTemplate.all
  end
end
