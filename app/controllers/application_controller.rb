class ApplicationController < ActionController::Base
  protect_from_forgery

  prepend_before_filter :redirect_to_www

  def admin_user
    @admin_user || (session[:typus_user_id].present? && AdminUser.find(session[:typus_user_id]))
  end

  def update_state
    cookies[:page] ||= -1
    cookies[:page] = cookies[:page].to_i + 1
  end

  def initialize_state
    cookies[:page] ||= 0
  end

  def require_admin
    redirect_to root_path unless admin_user.present?
  end

  def reset_state
    cookies[:page] = nil
  end

  def redirect_to_www
    if Rails.env.production? && request.host.include?('likeweirdstuff.com')
      unless request.host.start_with?('www')
        redirect_to "http://www.#{request.host}#{request.path}", status: :moved_permanently
      end
    end
  end
end
