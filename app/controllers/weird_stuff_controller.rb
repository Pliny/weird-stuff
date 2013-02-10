class WeirdStuffController < ApplicationController

  def index
    @weird_site = WeirdSite.random
  end
end
