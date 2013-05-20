class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    user_root_path
  end

  def owns_sc
    s = Socialcard.where(:user => current_user)
    unless s
      render :json => {
        :success => false,
        :message => "There was an error processing your request."
      }
    end
  end

  def clean_scs
    current_user.socialcards.where("username IS NULL").all.each do |s|
      s.destroy
    end
  end

  def authenticated?
    if user_signed_in?
      redirect_to user_root_path
    end
  end
end
