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

  KindCn = {
    0 => "前端社区",
    1 => "编程社区",
    2 => "开源项目",
    3 => "技术博客",
    4 => "其他",
  }

  def kind_cn
    KindCn[self.kind].to_s
  end

  def self.kind_cn(kind)
    KindCn[kind].to_s
  end
end
