class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  belongs_to :company
  belongs_to :role

  has_many :permissions
  has_many :messages
  has_many :tickets

  has_and_belongs_to_many :projects
  has_and_belongs_to_many :tasks

  validates_presence_of :username, :full_name, :email
  validates_length_of :username, :full_name, :email, maximum: 255
  validates_uniqueness_of :username, :email
#   TODO add email regex

  # TODO make hook after delete to check if user primary contact

  Role.pluck(:name).each do |role_name|
    define_method "#{role_name}?" do
      role.name == role_name
    end
  end

end
