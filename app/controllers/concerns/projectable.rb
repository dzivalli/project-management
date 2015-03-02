module Projectable
  extend ActiveSupport::Concern

  included do
    before_action :find_project, only: [:new, :edit, :show]
  end

  private

  def project(&block)
    if block_given?
      Project.class_eval(&block).client_projects(client).find(params[:project_id])
    else
      Project.client_projects(client).find(params[:project_id])
    end

  end

  def find_project
    @project = project
  end

end
