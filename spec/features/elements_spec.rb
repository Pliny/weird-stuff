require 'spec_helper'

describe "Elements" do

  subject { page.body }

  describe "index" do

    before { visit root_path }

    it { should have_selector('#fb-root') }
    it { should have_selector('#facebook-like') }
  end
end
