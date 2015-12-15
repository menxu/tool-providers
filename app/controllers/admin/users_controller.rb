class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.all
  end

  def edit
    @user = User.find params[:id]
  end

  def change_index
    @user = User.find params[:id]
  end

  def change_pwd
    Rails.logger.info params[:user][:password]
    @user = User.find params[:id]
    if @user.update(params.require(:user).permit(:password, :password_confirmation))
      flash[:notice] = '跟新成功'
    else
      flash[:error] = '跟新失败'
    end
    redirect_to :back
  end

  def update
    @user = User.find params[:id]
    if @user.update(params.require(:user).permit(:email, :name, :publish_email, :description))
      flash[:success] = '跟新成功'
    else
      flash[:error] = '跟新失败'
    end
    redirect_to admin_users_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :name, :password, :publish_email, :description))
    if @user.save
      flash[:notice] = '创建成功'
    else
      flash[:notice] = '创建失败'
    end
    redirect_to admin_users_path
  end

  def destroy
    @user = User.find params[:id]
    if @user.destroy
      flash[:notice] = '删除失败'
    else
      flash[:notice] = '删除成功'
    end
    redirect_to admin_users_path   
  end

  private
  def check_params
    params[:user].permit(:email, :name, :publish_email, :description)
  end
end
