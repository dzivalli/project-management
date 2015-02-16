module ApplicationHelper
  def time_now
    Time.now.strftime("%d-%m-%Y %H:%M")
  end

  def convert_time(time)
    time.strftime("%d-%m-%Y %H:%M:%S") if time
  end

  def get_name(version)
    # TODO if user change name of object
    if version.event != 'destroy' && version.event != 'delete'
      item_klass = version.item_type
      item_id = version.item_id
      if item_klass.constantize.find_by_id(item_id)
        item_klass.constantize.find(item_id).name
      end
    else
      version.object['name']
    end
  end

  def status_label(status)
    case status
      when 'новая'
        content_tag :div, status, class: 'label label-danger'
      when 'ответ послан'
        content_tag :div, status, class: 'label label-default'
      when 'в процессе'
        content_tag :div, status, class: 'label label-primary'
      when 'закрыта'
        content_tag :div, status, class: 'label label-success'
    end
  end
end
