class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:profile]

  def profile
    @scs = current_user.socialcards

    if @scs.length == 0
      s = Socialcard.new
      s.username = "donkey"
      s.user_id = current_user.id
      s.save!
    end

    @scs = current_user.socialcards
  end
end