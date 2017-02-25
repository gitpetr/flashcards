Rails.application.routes.draw do
  resources :packs
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  resources :cards
  resources :users
  resources :user_sessions
  patch '/check_translation/:id', to: 'home#update', as: "/check_translation"
  # resources :home, only: [:index, :update]
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
