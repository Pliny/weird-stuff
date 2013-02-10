class ApplicationController < ActionController::Base
  protect_from_forgery

  def admin_user
    @admin_user || (session[:typus_user_id].present? && AdminUser.find(session[:typus_user_id]))
  end
end
