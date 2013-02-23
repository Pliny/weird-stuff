class ApplicationController < ActionController::Base
  protect_from_forgery

  prepend_before_filter :redirect_to_www

  def admin_user
    @admin_user || (session[:typus_user_id].present? && AdminUser.find(session[:typus_user_id]))
  end

  def update_state
    if request.xhr?
      session[:page] ||= -1
      session[:page] = session[:page].to_i + 1
    end
  end

  def initialize_state
    session[:page] ||= 0
  end

  def require_admin
    redirect_to root_path unless admin_user.present?
  end

  def reset_state
    session[:page] = nil
    session[:current_id] = nil
  end

  def redirect_to_www
    if Rails.env.production? && request.host.include?('likeweirdstuff.com')
      unless request.host.start_with?('www')
        redirect_to "http://www.#{request.host}#{request.path}", status: :moved_permanently
      end
    end
  end
end
