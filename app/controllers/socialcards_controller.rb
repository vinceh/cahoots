class SocialcardsController < ApplicationController

  def new
    #@s = Socialcard.new
    #@s.usecase = params[:type]
    #@s.save!
    render :layout => "newsc"
  end
end