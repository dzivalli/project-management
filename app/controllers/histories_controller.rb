class HistoriesController < ApplicationController
  def index
    @project = Project.find params[:project_id]
    # TODO find in Paper Trail api more simple way to query
    projects = PaperTrail::Version.where(item_type: 'Project', item_id: @project.id).to_a
    milestones = PaperTrail::Version.where(item_type: 'Milestone', item_id: @project.milestones.ids).to_a
    tasks = PaperTrail::Version.where(item_type: 'Task', item_id: @project.tasks.ids).to_a
    @versions = projects + milestones + tasks
  end
end
