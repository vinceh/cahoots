class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:profile]

  def profile
    @scs = current_user.socialcards
  end
end