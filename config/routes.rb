Kahoots::Application.routes.draw do

  devise_for :users do
    get 'users', :to => 'users#profile', :as => :user_root
    get 'profile', :to => 'users#profile', :as => :user_root_path
  end

  root :to => 'home#index'
end
