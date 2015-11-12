class Settings::NotificationsController < Settings::ApplicationController
  def show
  end
  def update
    if @user.update(params.require(:user).permit(:publish_email, :name, :description))
      flash[:notice] = '更新成功'
      redirect_to settings_notifications_path
    else
      flash.now[:error] = '更新失败'
      render :show
    end
  end
end
