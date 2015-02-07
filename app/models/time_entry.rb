class TimeEntry < ActiveRecord::Base
  include ActionView::Helpers::TextHelper


  belongs_to :project
  belongs_to :user
  belongs_to :task

  def self.for_project(project)
    where(task: project.tasks)
  end

  def spent
    h, m, s = 0, 0, 0
    interval = updated_at - created_at
    m, s = interval.divmod(60)
    if interval >= 3600
      h, m = m.divmod(60)
    end
    # TODO use russian pluralize
    hours = "#{pluralize(h.to_i, 'час', 'часа')}" if h > 0
    min = "#{pluralize(m.to_i, 'минута', 'минуты')}" if m > 0
    s > 0 ? sec = "#{s.round} секунд" : sec = "#{interval.round} секунд"
    [hours, min, sec].compact!.join(', ')
  end
end
