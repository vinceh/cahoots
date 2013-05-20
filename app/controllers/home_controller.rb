class HomeController < ApplicationController
  protect_from_forgery

  before_filter :authenticated?, :only => [:index]
end
