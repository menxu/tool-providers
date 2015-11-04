class UsersController < ApplicationController

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
end
