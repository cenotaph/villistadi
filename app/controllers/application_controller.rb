class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :get_locale
  before_filter :get_background
  
  def get_background
    @background_image = Randombackground.active.random
    if @background_image.nil?
      @background_image = 'assets/cropped-panorama-okko.jpg'
    else
      @background_image = @background_image.background.url(:full)
    end
    if Rails.env.development?
      @background_css = 'background-color: pink;'
    end
  end
  
  def get_locale 
    if params[:locale]
      session[:locale] = params[:locale]
    end
    
    if session[:locale].blank?
      available  = %w{fi en}
      I18n.locale = http_accept_language.compatible_language_from(available)
      session[:locale] = I18n.locale
    else
      I18n.locale = session[:locale]
    end
  end
  protected
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_token, :remember_created_at, :sign_in_count) }
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :username,  :email,  authentications_attributes: [:id, :provider, :username ], role_ids: [] )}    
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :name, :username, :password_confirmation, authentications_attributes: [:id, :provider, :username ] ) }
  end
  
end
