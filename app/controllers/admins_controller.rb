class AdminsController < ApplicationController

  before_filter :authenticate_admin!

  def controlpanel
    @s = Socialcard.get_all
  end
end