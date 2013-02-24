class ApplicationController < ActionController::Base
  protect_from_forgery

  prepend_before_filter :redirect_to_www

  def admin_user
    @admin_user || (session[:typus_user_id].present? && AdminUser.find(session[:typus_user_id]))
  end

  def update_state
    session[:page] = session[:page].to_i + 1
    if (next_site = WeirdSite.find(session[:current_id]).next).nil?
      session[:completed] = true
    else
      session[:current_id] = next_site.id
    end
  end

  def initialize_state
    session[:page] = 0
    session[:current_id] ||= WeirdSite.first_asc.id
  end


  def require_admin
    head :unauthorized unless admin_user.present?
  end

  def async_only
    head :unauthorized unless request.xhr?
  end

  def reset_state
    session[:page]       = nil
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
