class Message < ActiveRecord::Base
  belongs_to :user

  scope :my, -> (id) { where("? = ANY (recipients) OR user_id = ?", id, id) }

  def self.by_user_and_recipient(user_id, recipient_id)
    where("(? = ANY (recipients) AND user_id = ?) OR (? = ANY (recipients) AND user_id = ?)",
          recipient_id, user_id, user_id, recipient_id).order(created_at: :desc)
  end

  def self.recipients_for(my_id)
    ids = my(my_id).pluck(:user_id, :recipients).flatten(1).uniq
    ids.reject! do |id|
      if id.is_a?(Array)
        id.include? my_id
      else
        id == my_id
      end
    end.flatten.uniq
    User.find(ids)
  end

  def my?(id)
    user_id == id
  end
end
