require 'spec_helper'

describe ApplicationHelper do

  subject { helper }

  it { should respond_to :bg_color_of }

  it "should choose the page's color" do
    bg_color_of(4).should == {
      header:       'bg-color04',
      top_angle:    'angle04',
      bottom_angle: 'angle05',
      footer:       'bg-color05',
      font:         'color03',
      facebook:     'share-facebook03',
      twitter:      'share-twitter03'
    }
  end

  it "should wrap at 14" do
    bg_color_of(13).should == {
      header:       'bg-color13',
      top_angle:    'angle13',
      bottom_angle: 'angle00',
      footer:       'bg-color00',
      font:         'color12',
      facebook:     'share-facebook12',
      twitter:      'share-twitter12'
    }
  end

  it "should handle the special case when page is 0" do
    bg_color_of(0).should == {
      header:       'bg-color00',
      top_angle:    'angle00',
      bottom_angle: 'angle01',
      footer:       'bg-color01',
      font:         'initial-color',
      facebook:     'initial-share-facebook',
      twitter:      'initial-share-twitter'
    }
  end

  it "should handle large page numbers" do
    bg_color_of(42).should == {
      header:       'bg-color00',
      top_angle:    'angle00',
      bottom_angle: 'angle01',
      footer:       'bg-color01',
      font:         'color13',
      facebook:     'share-facebook13',
      twitter:      'share-twitter13'
    }
  end

  it "should handle large page numbers 2" do
    bg_color_of(15).should == {
      header:       'bg-color01',
      top_angle:    'angle01',
      bottom_angle: 'angle02',
      footer:       'bg-color02',
      font:         'color00',
      facebook:     'share-facebook00',
      twitter:      'share-twitter00'
    }
  end
end

