Rails.application.routes.draw do

  resources :groups

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users

  devise_scope :user do
  get 'sign_out', :to => 'devise/sessions#destroy'#, :as => :destroy_user_session
  end

  get 'about' => 'welcome#about'
  
  root to: "welcome#index"
end
