class HomeController < ApplicationController
  def index
    render 'nologin'
  end

  def welcome
  end

  def search
  	@q = params[:q]
  	# @tools = Tool.search do
   #    fulltext "*#{params[:q]}*"
   #    paginate page: 1, per_page: 5
   #  end.results
    @users = User.search do
      fulltext "*#{params[:q]}*"
      paginate page:1, per_page: 5
      with(:status, 'opened')
    end.results
  end
end
