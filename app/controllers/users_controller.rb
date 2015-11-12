class UsersController < ApplicationController
  before_action :user, only: [:funs, :tools, :blogs, :show]

  def email_validate
    email = params[:email]
    user = User.new(email: email)
    error_message = valid_on(user, :email)
    if error_message
      render_fail(error_message)
    else
      render_success
    end
  end

  def search
    @q = params[:q]
    @users = User.search do
      fulltext "*#{params[:q]}*"
      paginate page:1, per_page: 5
    end.results    
  end

  def show
    respond_to do |format|
      format.html
      format.json
    end
  end

  def funs
  end

  def tools
  end

  def blogs
  end

  protected
  def user
    @user = User.find( params[:id] )
  end
end
