class PreferenceSource < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :user_id
  validates_presence_of :source_name, :user_id
end
