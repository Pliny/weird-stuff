require 'spec_helper'

describe WeirdStuffController do

  describe "GET 'index'" do

    describe "synchronously" do

      it "should be success" do
        get :index
        response.should be_success
      end
    end

    describe "asynchronously" do

      it "should be success" do
        xhr :get, :index
        response.should be_success
      end
    end

    it "should set a random weird page to like" do
      site = FactoryGirl.create(:weird_site)
      WeirdSite.should_receive(:random).once.and_return(site)
      get :index
    end

    it "should set the admin user if logged in" do
      subject.should_receive(:admin_user).once.and_return(nil)
      get :index
    end

    it "should initialize the cookie state" do
      get :index
      response.cookies['page'].should == 0.to_s
    end
  end

  describe "GET 'skip'" do

    describe "admin user" do

      before { login :admin }

      it "should be success" do
        get :skip
        response.should be_success
      end

      it "should increment the page index after skipping a 'like'" do
        request.cookies['page'] = 1.to_s
        get :skip
        response.cookies['page'].should == 2.to_s
      end
    end

    describe "unknown user" do

      it "should redirect to root page" do
        get :skip
        response.should redirect_to root_path
      end
    end

  end
end
