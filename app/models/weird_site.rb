class WeirdSite < ActiveRecord::Base
  attr_accessible :name, :url, as: :admin
  attr_accessible :name, :url

  validates_length_of :url, maximum: 512
  validates_length_of :name, maximum: 64

  validates_presence_of :url
  validates_presence_of :name

   validates_uniqueness_of :url
   validates_uniqueness_of :name
end
