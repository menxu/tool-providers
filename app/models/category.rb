class Category < ActiveRecord::Base
  has_many :blogs
  mount_uploader :icon, PhotoUploader
end
