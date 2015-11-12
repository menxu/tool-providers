class HomeController < ApplicationController
  def index
    @users = User.default_order.limit(3)
    # @users = []
    @tools = []
    @blogs = []
    @sites = []
    render 'nologin'
  end

  def welcome
  end

  def search
  	@q = params[:q]
    @users = User.search do
      fulltext "*#{params[:q]}*"
      paginate page:1, per_page: 5
    end.results
  end
end
