require 'spec_helper'

describe WeirdStuffController do

  describe "GET 'index'" do

    it "should be success" do
      get :index
      response.should be_success
    end

    it "should set a random weird page to like" do
      site = FactoryGirl.create(:weird_site)
      WeirdSite.should_receive(:random).once.and_return(site)
      get :index
    end
  end

end
