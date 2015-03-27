module Projectable
  extend ActiveSupport::Concern

  included do
    layout 'modal', only: [:new, :edit, :templates, :invoice, :copy]
  end

  private

  def find_project(&block)
    key = if self.class.name == 'ProjectsController'
            :id
          else
            :project_id
          end
    if block_given?
      Project.class_eval(&block).client_projects(client, current_user).find(params[key])
    else
      Project.client_projects(client, current_user).find(params[key])
    end

  end

end
