class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_account_update_params, if: :devise_controller?

  def new
    super
  end

  def create
    @user = User.new(sign_up_params)

    if @user.save
      flash[:notice] = '注册成功'
      Rails.logger.info("sign_up(:user, @user)===============#{sign_up(:user, @user)}")
      # Rails.logger.info(@user.to_json)
      # Rails.logger.info("sign_in=======#{sign_up(:user, @user)}")
      # Rails.logger.info("current_user==============#{current_user}")
      # Rails.logger.info("current_user.try(:confirmed?)==============#{current_user.try(:confirmed?)}")
      render_success
    else
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
    # devise_parameter_sanitizer.for(:sign_up) << :attribute
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
