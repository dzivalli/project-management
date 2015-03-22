class Role < ActiveRecord::Base

  has_many :users

  def by_client
    joins(:users).where(users: {id: client.users.ids})
  end

  scope :without_root, -> { where.not(name: 'root')}
  scope :admin, -> { find_by_name('admin') }
  scope :root, -> { find_by_name('root') }
  scope :staff, -> { find_by_name('staff') }
  scope :customer, -> { find_by_name('customer') }
end
