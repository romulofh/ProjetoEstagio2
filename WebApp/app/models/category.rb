class Category < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  def name=(upname)
    write_attribute :name, upname.upcase
  end
end
