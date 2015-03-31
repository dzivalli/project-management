class TimeEntry < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  belongs_to :project, -> { with_deleted }
  belongs_to :user, -> { with_deleted }
  belongs_to :task

  def self.completed(project)
    where(task: project.tasks, status: 'completed')
  end

  def self.logged_time_for(obj)
    case obj.class.name
      when 'Project'
        entries = where(project: obj, status: 'completed')
      when 'Milestone'
        entries = where(task: obj.tasks.ids, status: 'completed')
      when 'Task'
        entries = where(task: obj, status: 'completed')
    end
    entries.inject(0) do |sum, entry|
      sum + (entry.updated_at - entry.created_at)
    end
  end
end
