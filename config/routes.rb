Kahoots::Application.routes.draw do

  devise_for :admins do
    get 'controlpanel', :to => 'admins#controlpanel', :as => :admin_root
    get 'controlpanel/stats', :to => 'admins#stats', :as => :admin_stats
  end

  devise_for :users do
    get 'profile', :to => 'users#profile', :as => :user_root
  end

  post 'socialcard/new', :to => 'socialcards#new', :as => :new_socialcard
  get 'socialcard/edit/:username', :to => 'socialcards#edit', :as => :edit_socialcard
  get ':username', :to => 'socialcards#show', :as => :show_socialcard
  delete 'socialcard/:id', :to => 'socialcards#destroy', :as => :delete_socialcard

  root :to => 'home#index'

  # API
  get 'api/sc/:id', :to => 'socialcards#api_get'
  get 'api/sc-unique/:name', :to => 'socialcards#api_sc_unique'
  post 'api/sc/upload-avatar/:id', :to => 'socialcards#api_sc_upload_avatar'
  put 'api/sc/update/:id', :to => 'socialcards#api_update'
end
