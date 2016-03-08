class Blog
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Sunspot::Mongo

  field :name, type: String
  field :kind, type: Integer, default: 0
  field :category_id, type: Integer
  field :desc, type: String
  field :level, type: Integer, default: 0
  field :integrate, type: Integer, default: 0
  field :visit, type: Integer, default: 0
  field :content, type: String
  field :status, type: Integer, default: 0
  field :authorize, type: Integer, default: 0
  field :updated_count, type: Integer, default: 0

  belongs_to :category
end
