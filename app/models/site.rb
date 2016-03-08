class Site
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Sunspot::Mongo

  
  field :name, type: String
  field :kind, type: Integer
  field :desc, type: String
  field :icon, type: String
  field :url, type: String
end