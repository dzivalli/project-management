module Noticable
  extend ActiveSupport::Concern

  def notice!(client)
    template = case self.class
                 when Project then 'Назначение проекта'
                 when Task then 'Назначение задачи'
               end
    users.each do |user|
      Notifications.notice(name, user.email, template, client).deliver_later
    end
    true
  end

end