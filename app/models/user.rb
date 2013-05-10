class User < ActiveRecord::Base

  has_many :socialcards

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :tos

  validates :tos, :acceptance => true, :on => :create
end
