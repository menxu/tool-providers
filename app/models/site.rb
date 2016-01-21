class Site < ActiveRecord::Base
  KindCn = ["前端社区","编程社区","开源项目", "技术博客", "其他"]

  def kind_cn
    KindCn[self.kind].to_s
  end

  def self.kind_cn(kind)
    KindCn[kind].to_s
  end
end
