class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :name #博客名称
      t.integer :kind #body类型 文字 图片 音乐 视频
      t.integer :category_id #博客分类
      t.string :desc #博客描述
      t.integer :level #博客等级
      t.integer :integrate #博客积分
      t.integer :visit #博客浏览次数
      t.text :content #内容
      t.integer :status #可用 不可用
      t.integer :authorize #授权
      t.integer :updated_count #修改次数
      t.timestamps null: false
    end

    add_index :blogs, :name
    add_index :blogs, :category_id
    add_index :blogs, :status
  end
end
