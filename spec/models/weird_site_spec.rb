require 'spec_helper'

describe WeirdSite do

  before { @site = WeirdSite.new(url: 'http://someweirdsite.com', name: 'Weird Shit') }

  subject { @site }

  it { should respond_to :name }
  it { should respond_to :url }

  describe "validations" do

    it "should not allow urls larger than 512 characters" do
      WeirdSite.new(url: 'http://'+'h'*513+'.com').should have(1).error_on :url
    end

    it "should not allow the name to be larger than 64 characters" do
      WeirdSite.new(name: 'h'*65).should have(1).error_on :name
    end

    it "should require a url" do
      WeirdSite.new.should have(2).error_on :url
    end

    it "should require a name" do
      WeirdSite.new.should have(1).error_on :name
    end

    it "should have a unique URL" do
      FactoryGirl.create(:weird_site, url: 'http://weirdstuff.com', name: 'Weird')
      WeirdSite.new(url: 'http://weirdstuff.com').should have(1).error_on :url
    end

    it "should have a unique Name" do
      FactoryGirl.create(:weird_site, url: 'http://weirdstuff.com', name: 'Weird')
      WeirdSite.new(name: 'Weird').should have(1).error_on :name
    end

    it "should have a valid URL" do
      WeirdSite.new(url: 'bad url').should have(1).error_on :url
    end
  end

  describe ".random" do

    it "should return a random weird site" do
      WeirdSite.should_receive(:first).once.with(order: "RANDOM()").and_return(FactoryGirl.create(:weird_site))
      WeirdSite.random
    end
  end

  describe ".next" do

    it "should return the next weird site" do
      site = Array.new
      2.times { |i| site[i] = FactoryGirl.create(:weird_site) }
      WeirdSite.next(site[0].id).should == site[1]
    end

    it "should return next weird site even if it's not sequential" do
      site = Array.new
      3.times { |i| site[i] = FactoryGirl.create(:weird_site) }
      site[1].delete
      WeirdSite.next(site[0].id).should == site[2]
    end

    it "should wrap to the beginning if it's at the end" do
      site = Array.new
      2.times { |i| site[i] = FactoryGirl.create(:weird_site) }
      WeirdSite.next(site[1].id).should == site[0]
    end

    it "should not allow strings" do
      site = FactoryGirl.create(:weird_site)
      WeirdSite.next('blablabla').should == site
    end

    it "should handle the case when no id is given" do
      site = Array.new
      2.times { |i| site[i] = FactoryGirl.create(:weird_site) }
      WeirdSite.next(nil).should == site[0]
    end
  end
end
