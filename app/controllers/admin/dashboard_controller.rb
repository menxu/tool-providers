class Admin::DashboardController < Admin::ApplicationController
  def index
    @users_count = User.count
    @categories_count = Category.count
    @blogs_count = Blog.count
    @sites_count = Site.count

    @graphing_line_data = [
      {name: "用户", data: User.aggregate_by_date},
      {name: "分类", data: Category.aggregate_by_date},
      {name: "博客", data: Blog.aggregate_by_date},
      {name: "酷站", data: Site.aggregate_by_date}
    ]
    @graphing_pie_data =  0 # User.group(:name).count
    @graphing_column_data = [
      {name: "用户", data: User.aggregate_by_date},
      {name: "分类", data: Category.aggregate_by_date},
      {name: "博客", data: Blog.aggregate_by_date},
      {name: "酷站", data: Site.aggregate_by_date}
    ]
    @graphing_bar_data =  0#User.group(:name).sum(:id)
    @graphing_area_data = [
      name: "登陆",
      # data: User.group("strftime('%Y-%m', users.updated_at)").maximum(:sign_in_count)
    ]
    Rails.logger.info @graphing_data
  end
end
