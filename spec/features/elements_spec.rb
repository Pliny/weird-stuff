require 'spec_helper'

describe "Elements" do

  subject { page.body }

  describe "index" do

    before do
      @site = FactoryGirl.create(:weird_site)
    end

    describe "without admin privileges" do

      before { visit root_path }

      it { should have_selector('#fb-root') }
      it { should have_selector("#facebook-like[data-href=\"#{@site.url}\"]") }
      it { should_not have_selector("form > input[type=\"submit\"]") }
      it { should_not have_selector("#admin-notification") }
    end

    describe "with admin privileges" do

      before do
        integration_login :admin
        visit root_path
      end

      it { should have_selector("form > input[type=\"submit\"]") }
      it { should have_selector("#admin-notification") }
    end
  end
end
