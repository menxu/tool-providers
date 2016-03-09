class Blog
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name, type: String
  field :kind, type: Integer, default: 0
  field :desc, type: String
  field :level, type: Integer, default: 0
  field :integrate, type: Integer, default: 0
  field :visit, type: Integer, default: 0
  field :content, type: String
  field :status, type: Integer, default: 0
  field :authorize, type: Integer, default: 0
  field :updated_count, type: Integer, default: 0

  belongs_to :category
  belongs_to :user
  scope :passed, -> { where(status: 0) }

  # searchable do #if: proc { |blog| blog.passed? } do
  #   text :name
  #   text :desc
  #   integer :status
  #   integer :category_id
  # end

  KindCn = {
    0 => "原创",
    1 => "转载",
    2 => "编译"
  }

  StatusCn = {
    0 => "发表",
    1 => "仅自己可见",
    2 => "草稿箱"
  }

  def kind_cn
    KindCn[self.kind].to_s
  end

  def self.kind_cn(kind)
    KindCn[kind].to_s
  end

  def status_cn
    StatusCn[self.status].to_s
  end
  def self.status_cn(status)
    StatusCn[status].to_s
  end
end
