class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
  before_filter :configure_account_update_params, if: :devise_controller?

  # GET /resource/sign_up
  def new
    Rails.logger.info("Users::RegistrationsController#new->#{params}")
    super
  end

  # POST /resource
  def create
    # super
    Rails.logger.info("Users::RegistrationsController#create--------->#{sign_up_params}")
    if bit_enable?
      if false
        render_fail('注册失败', errors: { code: '邀请码不正确或已被使用'} )
        return
      end
    end
    @user = User.new(sign_up_params)
    if @user.save
      Rails.logger.info("====注册成功=====")
      flash[:notice] = '注册成功'
      sign_up(:user, @user)
      if bit_enable?
        InviteCode.mark_used(params[:code])
      end
      render_success
    else
      Rails.logger.info("====注册失败=====")
      render_fail('注册失败', @user)
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation)}
    # devise_parameter_sanitizer.for(:account_update) << :attribute
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :qq, :douban, :renren, :sinaweibo, :introduction, :work_experience, :education_experience, :fund_type, :min_invest, :max_invest, :focus_industry, :investment_philosophy, :added_value, :avatar)}
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private
  def bit_enable?
    ENV['BIT'].to_i == 1
  end

  helper_method :bit_enable?
end
