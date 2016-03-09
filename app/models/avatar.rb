class Avatar
  include Mongoid::Document
  field :image, type: String
  belongs_to :user
  mount_uploader :image, AvatarUploader
end
