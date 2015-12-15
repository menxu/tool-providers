class Admin::DashboardController < Admin::ApplicationController
  def index
    @users_count = User.count
    @categories_count = Category.count
    @blogs_count = Blog.count
    @sites_count = Site.count

    @graphing_line_data = [
      {name: "用户", data: User.group_by_day(:created_at)},
      {name: "分类", data: Category.group_by_day(:created_at)},
      {name: "博客", data: Blog.group_by_day(:created_at)},
      {name: "酷站", data: Site.group_by_day(:created_at)}
    ]
    @graphing_pie_data =   User.group(:name).count
    @graphing_column_data = [
      {name: "用户", data: User.group_by_day(:created_at)},
      {name: "分类", data: Category.group_by_day(:created_at)},
      {name: "博客", data: Blog.group_by_day(:created_at)},
      {name: "酷站", data: Site.group_by_day(:created_at)}
    ]
    @graphing_bar_data = User.group(:name).sum(:id)
    @graphing_area_data = [
      name: "登陆",
      data: User.group("strftime('%Y-%m', users.updated_at)").maximum(:sign_in_count)
    ]
    # @graphing_area_data = User.group_by_minute(:created_at)
    # @graphing_area_data = [
    #     { name: "Revenue",
    #       data: {"Sun, 18 May 2014 00:00:00 UTC +00:00"=>20,
    #              "Sun, 25 May 2014 00:00:00 UTC +00:00"=>10,
    #              "Sun, 01 Jun 2014 00:00:00 UTC +00:00"=>30},
    #     },
    #     { name: "Expenses",
    #       data: {"Sun, 18 May 2014 00:00:00 UTC +00:00"=>7,
    #              "Sun, 25 May 2014 00:00:00 UTC +00:00"=>10,
    #              "Sun, 01 Jun 2014 00:00:00 UTC +00:00"=>4},
    #     },
    #   ]
    # column_chart Task.group_by_hour_of_day(:created_at, format: "%l %P").count
    Rails.logger.info @graphing_data
  end
end
