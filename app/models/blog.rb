class Blog < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  scope :passed, -> { where(status: 0) }

  searchable do #if: proc { |blog| blog.passed? } do
    text :name
    text :desc
    integer :status
    integer :category_id
  end

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

  def api_json
    self.to_json
  end
end
