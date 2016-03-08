class Avatar
  include Mongoid::Document
  field :image, type: String
  # attr_accessible :image
  belongs_to :user
  mount_uploader :image, AvatarUploader
end
