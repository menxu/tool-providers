class HomeController < ApplicationController
  def index
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
