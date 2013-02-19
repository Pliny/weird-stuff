class WeirdStuffController < ApplicationController

  respond_to :html

  before_filter :require_admin,    only: [ :skip, :reset ]
  before_filter :update_state,     only: :skip
  before_filter :initialize_state, only: :index
  before_filter :reset_state,      only: :reset

  def index
    @weird_site = WeirdSite.random
    @page_liked = cookies[:weird_name]
    cookies[:weird_name] = @weird_site.name

    @admin = admin_user

    @page = cookies[:page].to_i

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
end
