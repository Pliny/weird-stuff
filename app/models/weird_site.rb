class WeirdSite < ActiveRecord::Base
  attr_accessible :name, :url, as: :admin
  attr_accessible :name, :url

  validates_length_of :url, maximum: 512
  validates_length_of :name, maximum: 64

  validates_presence_of :url
  validates_presence_of :name

  validates_uniqueness_of :url
  validates_uniqueness_of :name

  validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

  def self.random
    self.first(order: "RANDOM()")
  end

  def next
    self.class.name.constantize.where("weird_sites.id > ?", self.id).first_asc
  end

  def previous
    self.class.name.constantize.where("weird_sites.id < ?", self.id).first_desc

  end

  def self.first_asc
    first(order: "weird_sites.id ASC")
  end

  def self.first_desc
    first(order: "weird_sites.id DESC")
  end
end
