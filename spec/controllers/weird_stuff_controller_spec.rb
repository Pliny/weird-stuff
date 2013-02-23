require 'spec_helper'

describe WeirdStuffController do

  describe "GET 'index'" do

    describe "synchronously" do

      it "should be success" do
        get :index
        response.should be_success
      end

      it "should not increment the page" do
        request.cookies['page'] = 1.to_s
        get :index
        response.cookies['page'].should_not == 2.to_s
      end
    end

    describe "asynchronously" do

      it "should be success" do
        xhr :get, :index
        response.should be_success
      end

      it "should increment the page index after liking a page" do
        request.cookies['page'] = 1.to_s
        xhr :get, :index
        response.cookies['page'].should == 2.to_s
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

    it "should set the weird site name for the next like" do
      site = FactoryGirl.create(:weird_site)
      get :index
      response.cookies['weird_name'].should == site.name
    end

    it "should set the weird site URL ofr the next like" do
      site = FactoryGirl.create(:weird_site)
      get :index
      response.cookies['weird_url'].should == site.url
    end
  end

  describe "GET 'skip'" do

    describe "admin user" do

      before { login :admin }

      it "should be success" do
        get :skip
        response.should be_success
      end
    end

    describe "unknown user" do

      it "should redirect to root page" do
        xhr :get, :skip
        response.should redirect_to root_path
      end
    end
  end

  describe "GET 'reset'" do

    describe "admin user" do

      before { login :admin }

      it "should redirect to the root page" do
        get :reset
        response.should redirect_to root_path
      end

      it "should reset the cookie state" do
        request.cookies[:page] = 5.to_s
        get :reset
        response.cookies.keys.should include 'page'
        response.cookies['page'].should be_nil
      end
    end

    describe "unknown user" do

      it "should redirect to root page and not change state" do
        get :reset
        response.should redirect_to root_path
      end
    end
  end
end
