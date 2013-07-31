class SocialcardsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :api_sc_upload_avatar, :api_update, :delete_socialcard], :unless => :admin_signed_in?
  before_filter :owns_sc, :only => [:api_sc_upload_avatar, :api_update, :delete_socialcard]

  def new
    @s = Socialcard.new
    @s.usecase = params[:type]
    @s.user = current_user
    @s.save!(:validate => false)
    render :layout => "newsc"
  end

  def show
    @s = Socialcard.where(:username => params[:username].downcase).first
    @show = true

    if mobile_device?
      render :layout => "mobile_view", :template => "socialcards/mobile_show"
    else
      render :layout => "viewsc"
    end
  end

  def iframe_show
    @s = Socialcard.where(:username => params[:username].downcase).first
    @show = true
    render "show", :layout => "iframesc"
  end

  def edit
    @s = Socialcard.where(:username => params[:username]).first
    render :layout => "newsc", :template => "socialcards/new.html.erb"
  end

  def destroy
    @s = Socialcard.find(params[:id])

    @s.providers.each do |p|
      p.destroy
    end

    @s.destroy
    redirect_to redirect_url
  end

  # API methods
  def api_get
    render :json => Socialcard.find(params[:id]).to_json
  end

  def api_sc_unique
    render :json => {
      :valid => !Socialcard.where(:username => params[:name].downcase).first
    }
  end

  def api_sc_upload_avatar
    s = Socialcard.find(params[:id])
    s.avatar = params[:avatar]
    s.save!(:validate => false)
    render :json => s.to_json
  end

  def api_update
    s = Socialcard.find(params[:id])
    params[:sc].except!(:avatar_url)
    params[:sc].except!(:id)
    providers = params[:sc][:providers]
    params[:sc].except!(:providers)

    if s.update_attributes(params[:sc])
      s.create_providers(providers)
      render :json => {
        :success => true,
        :redirect_url => redirect_url(newSC: s.id)
      }
    else
      render :json => {:success => false}
    end
  end
end