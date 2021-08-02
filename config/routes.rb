Rails.application.routes.draw do
  resources :toys, only: [:index, :create, :update]
  # resources :toys, only: [:index, :create, :update, :destroy]


  delete '/toys/:id', to: 'toys#destroy'
end
