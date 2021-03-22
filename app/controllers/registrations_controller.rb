class RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  
  protected

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  def after_update_path_for(_resource)
    user_path(current_user.id), notice: "アカウント情報を変更しました"
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname])
  end
end