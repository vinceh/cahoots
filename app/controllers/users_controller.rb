class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:profile]
  before_filter :clean_scs, :only => [:profile]

  def profile
    @scs = current_user.socialcards.where("username IS NOT NULL").order("created_at").reverse
  end
end