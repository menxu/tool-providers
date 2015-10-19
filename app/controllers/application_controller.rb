class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => '你没有权限访问该页面'
  end
  private
  def bit_enable?
    ENV['BIT'].to_i == 1
  end

  helper_method :bit_enable?
end
