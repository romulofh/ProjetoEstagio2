class Feed < ActiveRecord::Base
  validates_presence_of :source_name, :category_name, :url
  validates_uniqueness_of :url
end
