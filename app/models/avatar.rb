class Avatar < ActiveRecord::Base
  has_one :photo
  mount_uploader :image, AvatarUploader
end
