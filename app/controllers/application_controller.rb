class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include Pundit::Authorization
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
    user_dashboard_path
  end

  #Handle Pindit errors (optional but good  for UI)
rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    # Add :type to the sign_up params
    keys = [:email, :password, :password_confirmation, :type, :avatar]
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end  
end
