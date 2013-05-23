class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      user_root_path
    elsif resource.is_a?(Admin)
      admin_root_path
    end
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

  def redirect_url
    if admin_signed_in?
      admin_root_path
    elsif user_signed_in?
      user_root_path
    end
  end
end
