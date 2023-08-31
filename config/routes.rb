Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v0 do
      resources :market_vendors, only: [:create]
      delete '/market_vendors', to: 'market_vendors#destroy', as: :delete_market_vendors

      resources :vendors, only: [:show, :create, :update, :destroy]

      resources :markets, only: [:index, :show] do
        resources :vendors, only: [:index]
        
        member do
          get 'nearest_atm'
        end

        collection do
          get 'search'
        end
      end
    end
  end
end
