class WeirdStuffController < ApplicationController

  def index
    @weird_site = WeirdSite.random
    @admin = admin_user
  end
end
