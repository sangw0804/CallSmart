class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:update_attributes, keys: [:isPaid])
  end
end
