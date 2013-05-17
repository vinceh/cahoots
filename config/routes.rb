Kahoots::Application.routes.draw do

  devise_for :users do
    get 'profile', :to => 'users#profile', :as => :user_root
  end

  post 'socialcard/new', :to => 'socialcards#new', :as => :new_socialcard

  root :to => 'home#index'
end
