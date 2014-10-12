Rails.application.routes.draw do

  # get 'questions/new'

  # get 'questions/show'

  # get 'questions/index'

  # get 'meetings/new'

  # get 'meetings/create'

  # get 'meetings/index'

  # get 'meetings/show'

  # get 'meetings/destroy'

  # get 'meetings/edit'

  # get 'meetings/update'

  resources :groups do
    resources :meetings do
      resources :questions
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users

  devise_scope :user do
  get 'sign_out', :to => 'devise/sessions#destroy'#, :as => :destroy_user_session
  end

  get "request_access" => "groups#request_access"
  get "grant_access" => "groups#grant_access"
  get 'deny_access' => "groups#deny_access"

  get 'about' => 'welcome#about'
  
  root to: "welcome#index"
end
