class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  def after_sign_in_path_for(resource)
    lists_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password, :current_password , :password_confirmation , :name) }
  end

end
