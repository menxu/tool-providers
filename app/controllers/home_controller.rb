class HomeController < ApplicationController
  def index
  	# render :text => 'nologin'
  end

  def welcome
  end

  def search
  	@q = params[:q]
  	# @projects = Project.search do
   #    fulltext "*#{params[:q]}*"
   #    paginate page: 1, per_page: 5
   #  end.results
  end
end
