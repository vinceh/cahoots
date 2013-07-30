Kahoots::Application.routes.draw do

  devise_for :admins do
    get 'controlpanel', :to => 'admins#controlpanel', :as => :admin_root
    get 'controlpanel/stats', :to => 'admins#stats', :as => :admin_stats
  end

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"} do
    get 'profile', :to => 'users#profile', :as => :user_root
    get 'cards/saved', :to => 'users#saved_cards', :as => :user_saved_cards
    post 'cards/save/:id', :to => 'users#save_card', :as => :user_save_card
    post 'cards/remove/:id', :to => 'users#remove_card', :as => :user_remove_card
  end

  post 'socialcard/new', :to => 'socialcards#new', :as => :new_socialcard
  get 'socialcard/edit/:username', :to => 'socialcards#edit', :as => :edit_socialcard
  delete 'socialcard/:id', :to => 'socialcards#destroy', :as => :delete_socialcard
  root :to => 'home#index'

  get 'about', :to => 'home#about', :as => :about
  get 'terms', :to => 'home#terms', :as => :terms
  get 'privacy', :to => 'home#privacy', :as => :privacy

  # API
  get 'api/sc/:id', :to => 'socialcards#api_get'
  get 'api/sc-unique/:name', :to => 'socialcards#api_sc_unique'
  post 'api/sc/upload-avatar/:id', :to => 'socialcards#api_sc_upload_avatar'
  put 'api/sc/update/:id', :to => 'socialcards#api_update'

  get ':username', :to => 'socialcards#show', :as => :show_socialcard
  get 'frame/:username', :to => 'socialcards#iframe_show', :as => :iframe_show_socialcard
end
