class WeirdStuffController < ApplicationController

  respond_to :html

  before_filter :require_admin,    only: [ :skip, :reset ]
  before_filter :initialize_state, only: :index
  before_filter :update_state,     only: :index
  before_filter :reset_state,      only: :reset

  def index
    @weird_site = WeirdSite.random

    set_info_for_current_page
    set_info_for_next_page

    @admin = admin_user

    @page = session[:page].to_i

    respond_with :index do |format|
      format.html do
        if request.xhr?
          render :index, :layout => false
        else
          render
        end
      end
    end
  end

  def skip
    head :ok
  end

  def reset
    redirect_to root_path
  end

  private

  def set_info_for_current_page
    @page_liked ||= {}
    @page_liked[:name] = session[:weird_name]
    @page_liked[:url]  = session[:weird_url]
  end

  def set_info_for_next_page
    session[:weird_name] = @weird_site.try(:name)
    session[:weird_url]  = @weird_site.try(:url)
  end
end
