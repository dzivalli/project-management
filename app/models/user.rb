class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable,
         :trackable, :validatable

  after_create :create_avatar!

  delegate :can?, :cannot?, to: :ability

  belongs_to :company
  belongs_to :role
  belongs_to :client

  has_many :permissions
  has_many :messages
  has_many :tickets
  has_many :task_templates

  mount_uploader :avatar, AvatarUploader

  has_and_belongs_to_many :projects
  has_and_belongs_to_many :tasks

  validates_presence_of :full_name, :email
  validates_length_of :full_name, :email, maximum: 255
  validates_uniqueness_of :email
#   TODO add email regex
  # TODO make hook after delete to check if user primary contact


  scope :customer_users, -> (client) { where(client: client).where.not(id: client.owner.id) }
  scope :customer_staff, -> (client) { where(client: client, role: Role.where(name: %w(staff admin))) }


  def ability
    @ability ||= Ability.new(self)
  end

  def confirmed?
    !!confirmed_at
  end

  def generate_token!
    self.confirmation_token = Digest::SHA1.hexdigest([Time.now, rand].join)
    self
  end

  def generate_password!
    self.password = self.password_confirmation = Devise.friendly_token
    self
  end

  def customer?
    role == Role.customer
  end

  def admin?
    role == Role.admin || root?
  end

  def staff?
    role == Role.staff
  end

  def root?
    role == Role.root
  end

  def admin!
    update(role: Role.admin)
    self
  end

  def root!
    update(role: Role.root)
    self
  end

  def staff!
    update(role: Role.staff)
    self
  end

  def customer!
    update(role: Role.customer)
    self
  end

  def prepare
    generate_password!
    generate_token!
    admin!
  end

  private

  def create_avatar!
    self.create_avatar
    self.save
  end
end
