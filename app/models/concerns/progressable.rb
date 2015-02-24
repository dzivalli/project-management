module Progressable
  extend ActiveSupport::Concern

  def progress
    time = (TimeEntry.logged_time_for(self)/3600).round
    if estimated_hours && estimated_hours != 0
      time == 0 ? 1 :(time / (estimated_hours.to_f/100)).round
    else
      100
    end
  end

end