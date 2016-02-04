class Photo < ActiveRecord::Base
  belongs_to :category
  mount_uploader :image, AvatarUploader
end
