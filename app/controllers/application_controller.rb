class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from Exception, :with => :error_render_method

  def error_render_method
    respond_to do |type|
      type.html { redirect_to "http://s3.amazonaws.com/cahoots404/404.html" }
      type.all  { render :nothing => true, :status => 404 }
    end
    true
  end

  def check_for_mobile
    session[:mobile_override] = params[:mobile] if params[:mobile]
    prepare_for_mobile if mobile_device?
  end

  def prepare_for_mobile
    prepend_view_path Rails.root + 'app' + 'views_mobile'
  end

  def mobile_device?
    if session[:mobile_override]
      session[:mobile_override] == "1"
    else
      # Season this regexp to taste. I prefer to treat iPad as non-mobile.
      (request.user_agent =~ /Mobile|webOS/) && (request.user_agent !~ /iPad/)
    end
  end
  helper_method :mobile_device?

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

  def redirect_url(options ={})
    if admin_signed_in?
      admin_root_path(options)
    elsif user_signed_in?
      user_root_path(options)
    end
  end
end
