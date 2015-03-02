class Role < ActiveRecord::Base
  has_many :users

  def by_client
    abort client
    joins(:users).where(users: {id: client.users.ids})
  end

end
