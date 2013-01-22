require 'spec_helper'

describe Admin::WeirdSitesController do

  describe "POST 'create'" do

    describe "by unknown user" do

      it "should redirect to admin login page" do
        post :create, weird_site: { url: "http://weirdsite.com", name: "Weird" }
        response.should redirect_to new_admin_session_url
      end
    end

    describe "by logged in user" do

      before do
        @admin = login(:admin)
      end

      describe "successfully" do

        it "should create a new weird site" do
          expect do
            post :create, weird_site: { url: "http://weirdsite.com", name: "Weird" }
          end.to change(WeirdSite, :count).by 1
        end

        it "should set the weird site name and url correctly" do
          post :create, weird_site: { url: "http://weirdsite.com", name: "Weird" }
          WeirdSite.all.size.should == 1
          site = WeirdSite.all.first
          site.url = "http://weirdsite.com"
          site.name = "Weird"
        end
      end

      describe "unsuccessfully" do

        it "should not create a new site" do
          expect do
            post :create, weird_site: { name: "Weird" }
          end.to_not change(WeirdSite, :count)
        end
      end
    end
  end
end
