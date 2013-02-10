require 'spec_helper'

describe ShareHelper do

  subject { helper }

  describe "Facebook" do

    it { should respond_to :facebook_share_url }

    it "should return a facebook url" do
      facebook_share_url.should == "https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Ftest.host%2F"
    end
  end

  describe "Twitter" do

    it { should respond_to :twitter_share_url }

    it "should return a twitter url" do
      twitter_share_url.should include "http://www.twitter.com"
    end
  end
end
