class TemplatesController < ApplicationController
  def index
    @task_templates = TaskTemplate.for_client(client)
    @milestone_templates = MilestoneTemplate.includes(:task_templates).for_client(client)
    @item_templates = ItemTemplate.for_client(client)
  end
end
