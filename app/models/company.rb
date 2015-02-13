class Company < ActiveRecord::Base
  has_many :users
  has_many :projects
  has_many :permissions
  belongs_to :contact, class_name: 'User'

  has_paper_trail

  validates_presence_of :name, :address
  validates_uniqueness_of :name
  validates_length_of :name, :address, maximum: 255

  scope :default, -> { find(Setting.company) }
  scope :every, -> { where.not(id: Setting.company) }

end
