class Avatar < ActiveRecord::Base
  has_one :photo
  mount_uploader :image, AvatarUploader
  has_one :user
end
