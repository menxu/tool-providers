class Avatar
  include Mongoid::Document
  field :image, type: String
  # attr_accessible :image
  belongs_to :user
  has_one :photo
  mount_uploader :image, AvatarUploader
end
