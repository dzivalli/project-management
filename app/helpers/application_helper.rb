module ApplicationHelper
  def time_now
    Time.now.strftime("%d-%m-%Y %H:%M")
  end

  def convert_time(time)
    time.strftime("%d-%m-%Y %H:%M:%S")
  end
end
