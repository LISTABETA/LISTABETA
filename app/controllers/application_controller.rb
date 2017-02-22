class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  private

  def not_authorized
    flash[:alert] = "Você não tem permissão para fazer isso."
    redirect_to(request.referrer || root_path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) do |params|
      params.permit(:email)
    end

    devise_parameter_sanitizer.permit(:sign_up) do |params|
      params.permit(:email, :name, :avatar, :avatar_cache)
    end

    devise_parameter_sanitizer.permit(:account_update) do |params|
      params.permit(:email, :name, :avatar, :avatar_cache, :password)
    end
  end
end
