class User < ActiveRecord::Base
  searchable do
    text :name, :email
  end

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable, #:async,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:weibo]

  has_many :authentications

  validates :name, presence: true
  has_one :avatar

  has_many :funs
  has_many :messages

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