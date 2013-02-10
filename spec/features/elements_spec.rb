require 'spec_helper'

describe "Elements" do

  subject { page.body }

  describe "index" do

    before do
      @site = FactoryGirl.create(:weird_site)
      visit root_path
    end

    it { should have_selector('#fb-root') }
    it { should have_selector("#facebook-like[data-href=\"#{@site.url}\"]") }
  end
end
