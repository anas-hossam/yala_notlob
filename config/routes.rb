Rails.application.routes.draw do

  get 'follows/index'

  get 'home/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users do
     resources :groups
  end
  resources :groups

  resources :groups do
    member do
      post :new_member
      delete :delete_member
     # post '/newfollow', to: 'users#newfollow'
    end
 end

  resources :follows
 match 'users/newfollow' => 'users#newfollow', :via => :post
  resources :users do
     member do
       get :follow
       get :unfollow
      # post '/newfollow', to: 'users#newfollow'
     end
  end
 #root 'users#index'
 root  'home#index' 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
