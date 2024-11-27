require "application_responder"

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?



  self.responder = ApplicationResponder
  respond_to :html

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username ])
  end
end
