class Category
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :key, type: String
  field :sdesc, type: String
  field :fdesc, type: String
  field :parent, type: String
  field :typcd, type: String
  field :home, type: String
  field :num, type: Integer, default: 0
  field :icon, type: String

  has_many :blogs
  mount_uploader :icon, PhotoUploader
end
