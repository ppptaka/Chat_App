class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception #セキュリティトークンが自動的に含まれる
  before_action :authenticate_user!, except: :index
  before_action :configure_permitted_parameters, if: :devise_controller? #deviseを使う画面に移動したときに動く

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :image])
    end
end
