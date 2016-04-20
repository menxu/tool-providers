class HomeController < ApplicationController
  def index
    @users = User.default_order.limit(3)
    @blogs = Blog.all
    # @users = []
    @tools = []
    @sites = Site.all
    render 'nologin'
  end

  def welcome
  end

  def search
    @q = params[:q]
    @users = User.search do
      fulltext "*#{params[:q].downcase}*"
      paginate page:1, per_page: 5
    end.results

    @blogs = Blog.search do
      fulltext "*#{params[:q].downcase}*"
      paginate page:1, per_page: 5
    end.results
  end
end
