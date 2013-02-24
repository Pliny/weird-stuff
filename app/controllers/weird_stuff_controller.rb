class WeirdStuffController < ApplicationController

  respond_to :html

  before_filter :require_admin,    only: [ :skip, :reset ]
  before_filter :async_only,       only: [ :skip, :next  ]
  before_filter :update_state,     only: :next
  before_filter :initialize_state, only: :index
  before_filter :reset_state,      only: :reset

  def index
    @weird_site_to_be_liked = WeirdSite.find session[:current_id]
    @page = session[:page]
    @landing_page = true
    @completed = session[:completed]
  end

  def next
    @weird_site_to_be_liked = WeirdSite.find session[:current_id]
    @weird_site_just_liked  = @weird_site_to_be_liked.previous
    @page = session[:page]
    @completed = session[:completed]
    render :index, layout: false
  end

  def skip
    head :ok
  end

  def reset
    redirect_to root_path
  end
end
