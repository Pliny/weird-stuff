class WeirdStuffController < ApplicationController

  respond_to :html

  def index
    @weird_site = WeirdSite.random
    @admin = admin_user

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
end
