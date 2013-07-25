class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:profile, :saved_cards, :save_card, :remove_card]
  before_filter :clean_scs, :only => [:profile]

  def profile
    @scs = current_user.socialcards.where("username IS NOT NULL").order("created_at").reverse
  end

  def saved_cards
    @cards = current_user.cards
  end

  def save_card

    unless Savedcard.where(:socialcard_id => params[:id], :user_id => current_user.id).first
      puts "FSDAFSDAFAFSDAFSADFSD"
      card = Socialcard.find(params[:id])
      saver = Savedcard.new
      saver.user = current_user
      saver.socialcard = card
      saver.save!
    end

    redirect_to user_saved_cards_path
  end

  def remove_card
    Savedcard.where(:socialcard_id => params[:id], :user_id => current_user.id).first.destroy
    redirect_to user_saved_cards_path
  end
end