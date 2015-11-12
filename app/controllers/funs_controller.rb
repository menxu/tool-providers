class FunsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.add_fun user
    render_success
  end

  def destroy
    current_user.remove_fun user
    render_success
  end

  protected
  def user
    User.find(params[:id])
  end
end
