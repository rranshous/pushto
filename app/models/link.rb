class Link < ActiveRecord::Base
  validates_uniqueness_of :short_name, :allow_blank => false
  validates :target_url, :url => true, :allow_blank => false
end
