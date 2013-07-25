class Savedcard < ActiveRecord::Base
  belongs_to :user
  belongs_to :socialcard
end