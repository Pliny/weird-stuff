require 'spec_helper'

describe WeirdSite do

  before { @site = WeirdSite.new(url: 'http://someweirdsite.com', name: 'Weird Shit') }

  subject { @site }

  it { should respond_to :name }
  it { should respond_to :url }

  describe "validations" do

    it "should not allow urls larger than 512 characters" do
      WeirdSite.new(url: 'h'*513).should have(1).error_on :url
    end

    it "should not allow the name to be larger than 64 characters" do
      WeirdSite.new(name: 'h'*65).should have(1).error_on :name
    end

    it "should require a url" do
      WeirdSite.new.should have(1).error_on :url
    end

    it "should require a name" do
      WeirdSite.new.should have(1).error_on :name
    end

    it "should have a unique URL" do
      FactoryGirl.create(:weird_site, url: 'http://weirdstuff.com', name: 'Weird')
      WeirdSite.new(url: 'http://weirdstuff.com').should have(1).error_on :url
    end

    it "should have a unique URL" do
      FactoryGirl.create(:weird_site, url: 'http://weirdstuff.com', name: 'Weird')
      WeirdSite.new(name: 'Weird').should have(1).error_on :url
    end

    pending "should have a valid URL" do
      WeirdSite.new(url: 'bad url').should have(1).error_on :url
    end
  end
end
