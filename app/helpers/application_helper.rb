module ApplicationHelper
  def time_now
    Russian::strftime(Time.now, "%d-%m-%Y")
  end

  def convert_time(time)
    time.strftime("%d-%m-%Y %H:%M") if time
  end

  def to_hours(hours)
    "#{hours} #{Russian::p(hours, 'час', 'часа', 'часов', 'часа')}" if hours
  end

  def to_minutes(min)
    "#{min} #{Russian::p(min, 'минута', 'минуты', 'минут')}" if min
  end

  def to_seconds(sec)
    "#{sec} #{Russian::p(sec, 'секунда', 'секунд', 'секунд')}" if sec
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

  def status(status, form = 'label')
    case status
      when 'новая', 'Перевод', 'просрочен'
        content_tag :div, status, class:  "#{form} #{form}-danger"
      when 'ответ послан', 'черновик', 'Онлайн', 'оплачен частично'
        content_tag :div, status, class: "#{form} #{form}-default"
      when 'в процессе', 'Наличные', 'неоплачен'
        content_tag :div, status, class: "#{form} #{form}-primary"
      when 'закрыта', 'оплачен'
        content_tag :div, status, class: "#{form} #{form}-success"
      else
        status
    end
  end

  def time_interval_to_human(interval)
    h, m, s = 0, 0, 0
    m, s = interval.divmod(60)
    if interval >= 3600
      h, m = m.divmod(60)
    end
    hours = to_hours(h) if h > 0
    m > 0 ? min = to_minutes(m) : min = nil
    s > 0 ? sec = to_seconds(s.round) : sec = nil
    if interval.zero?
      '0 часов'
    else
      [hours, min, sec].compact.join(', ')
    end
  end

  def name_for_versions(id)
    User.find_by_id(id) ? User.find(id).full_name : ''
  end

  def find_permission(permissions, action, obj)
    permissions.one? do |p|
      p[0] == action && p[1] == obj
    end
  end

  def active_task
    Task.all_active(current_user)
  end

  def user_tasks
    Task.for_user(current_user)
  end

  def new_message_count
    Message.my_unread(current_user.id).count
  end

  def new_messages_by_dialog_count(recipient_id)
    Message.by_user_and_recipient(current_user.id, recipient_id).my_unread(current_user.id).count
  end
end
