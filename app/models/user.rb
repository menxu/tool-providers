class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Sunspot::Mongo

  field :email, type: String, default: ''
  field :name, type: String
  field :encrypted_password, type: String, default: ''
  #Recoverable
  field :reset_password_token, type: String
  field :reset_password_sent_at, type: Time
  #Rememberable
  field :remember_created_at, type: Time

  # Trackable
  field :sign_in_count, type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at, type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String

  #Confirmable
  field :confirmation_token, type: String
  field :confirmed_at, type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email, type: String

  field :publish_email, type: Boolean, default: false
  field :description, type: String

  #Lockable
  # field :failed_attempts, type: Integer, default: 0
  # field :unlock_token, type: String
  # field :locked_at, type: Time

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, #:async, :invitable
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:weibo]

  embeds_many :authentications

  validates :name, presence: true
  has_one :avatar

  has_many :funs
  has_many :messages
  
  rolify

  scope :default_order, -> { order(created_at: :desc) }

  def mark_all_as_read
    self.messages.unread.update_all(is_read: true, read_at: DateTime.now)
  end

  def avatar_url
    if self.avatar.blank?
      self.avatar = Avatar.new
      self.save!
    end
    self.avatar.image_url
  end

  def remove_fun(user)
    self.funs.where(interested_user_id: user.id).destroy_all
  end

  def add_fun(user)
    unless self.funs.where(interested_user_id: user.id).first
      fun = Fun.new(user: self, interested_user_id: user.id)
      self.funs << fun
      self.save
    end
  end

  def fun?(user)
    !! self.funs.where(interested_user_id: user.id).first
  end
end