require 'spec_helper'

describe WeirdStuffController do

  before do
    @initial_site = FactoryGirl.create(:weird_site)
  end

  describe "GET 'index'" do

    it "should be success" do
      get :index
      response.should be_success
    end

    it "should not increment the page" do
      session[:page] = 1
      get :index
      session[:page].should_not == 2
    end

    it "should not get the next weird site" do
      site = Array.new
      2.times { |i| site[i] = FactoryGirl.create(:weird_site) }
      session[:current_id] = site[0].id
      get :index
      session[:current_id].should == site[0].id
    end

    describe "new user" do

      it "should initialize the cookie state" do
        get :index
        session[:page].should == 0
        session[:current_id].should == @initial_site.id
        session[:sites_liked].should == 0
      end
    end

    describe "returning user" do

      let(:site) { FactoryGirl.create(:weird_site) }

      it "should remember where they left off" do
        session[:current_id] = site.id
        get :index
        session[:page].should == 0
        session[:current_id].should == site.id
      end
    end
  end

  describe "GET 'skip'" do

    describe "admin user" do

      before { login :admin }

      describe "synchronous fetch" do

        it "should return unauthorized" do
          get :skip
          response.status.should == 401
        end
      end

      describe "asynchronous fetch" do

        it "should be success" do
          xhr :get, :skip
          response.should be_success
        end
      end
    end

    describe "unknown user" do

      describe "synchronous fetch" do

        it "should redirect to root page" do
          xhr :get, :skip
          response.status.should == 401
        end
      end

      describe "asynchronous fetch" do

        it "should redirect to root page" do
          xhr :get, :skip
          response.status.should == 401
        end
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

      it "should reset the page state" do
        session[:page] = 5.to_s
        get :reset
        session.keys.should include 'page'
        session[:page].should be_nil
      end

      it "should reset the current site state" do
        session[:current_id] = 5.to_s
        get :reset
        session.keys.should include 'current_id'
        session[:current_id].should be_nil
      end

      it "should reset the liked sites state" do
        session[:sites_liked] = 5.to_s
        get :reset
        session.keys.should include 'sites_liked'
        session[:sites_liked].should be_nil
      end

      it "should reset the completed state" do
        session[:completed] = true
        get :reset
        session.keys.should include 'completed'
        session[:completed].should be_nil
      end
    end

    describe "unknown user" do

      it "should redirect to root page and not change state" do
        get :reset
        response.status.should == 401
      end
    end
  end

  describe "GET 'next'" do

    it { should respond_to :next }

    describe "synchronously" do

      it "should return unauthorized" do
        get :next
        response.status.should == 401
      end
    end

    describe "asynchronously" do

      let(:site) { FactoryGirl.create(:weird_site) }

      before do
        session[:page] = 0
        session[:current_id] = @initial_site.id
        session[:sites_liked] = 0
      end

      it "should be success" do
        xhr :get, :next
        response.should be_success
      end

      it "should increment the page index after liking a page" do
        site
        xhr :get, :next
        session[:page].should == 1
      end

      it "should get the next weird site" do
        site
        xhr :get, :next
        session[:current_id].should == site.id
      end

      it "should load up the current page to like" do
        WeirdSite.should_receive(:find).twice.with(session[:current_id]).and_return site
        xhr :get, :next
      end

      it "should fetch the page to like" do
        WeirdSite.any_instance.should_receive(:next).once.and_return site
        xhr :get, :next
      end

      it "should load up the page previously liked" do
        WeirdSite.any_instance.should_receive(:previous).once.and_return @initial_site
        xhr :get, :next
      end

      it "should keep track of how many sites the user has liked" do
        xhr :get, :next
        session[:sites_liked].should == 1
      end

      describe "completed" do

        it "should indicate when all weird sites have been liked" do
          xhr :get, :next
          session[:completed].should == true
        end

        it "should not modify the current site" do
          xhr :get, :next
          session[:current_id].should == @initial_site.id
        end

        it "should only increment the sites liked once" do
          xhr :get, :next
          xhr :get, :next
          session[:sites_liked].should == 1
        end
      end
    end
  end
end
