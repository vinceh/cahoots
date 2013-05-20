class Provider < ActiveRecord::Base

  validates_presence_of :provider
  belongs_to :socialcard
end