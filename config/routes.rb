Rails.application.routes.draw do
  resources :cards
  patch '/home/:id', to: 'home#update'
  resources :home, only: [:index, :update]
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
