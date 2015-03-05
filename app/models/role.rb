class Role < ActiveRecord::Base
  default_scope { where.not(name: 'root') }

  has_many :users

  def by_client
    abort client
    joins(:users).where(users: {id: client.users.ids})
  end

end
