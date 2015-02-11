module ProjectCommon
  extend ActiveSupport::Concern

  included do
    before_action :find_project, only: [:new, :edit, :show]
  end

  private

  def find_project
    @project = Project.find params[:project_id]
  end

end
