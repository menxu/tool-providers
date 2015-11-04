class User < ActiveRecord::Base
  searchable do
    text :name, :email
  end

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :invitable, :confirmable, #:async, 
         :omniauthable, omniauth_providers: [:weibo]

  has_many :authentications

  validates :name, presence: true
  # has_one :avatar
  # # 投资角色
  # has_one :investor
  # has_many :investments
  # has_and_belongs_to_many :projects, join_table: :members
  # has_many :members
  # # 关注功能
  # has_many :stars
  # # 粉丝功能
  # has_many :funs
  # has_many :messages

  # has_many :events

  # has_and_belongs_to_many :person_requires

  scope :default_order, -> { order(created_at: :desc) }


end