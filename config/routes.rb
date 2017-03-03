Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' },
    defaults: { format: :json }

  namespace :api do
    namespace :v1 do
      resources :projects

      resources :users, only: [:index] do
        post 'time/:year/:month/:day', to: 'days#create', constraints: {
          year: /\d{4}/,
          month: /\d{2}/,
          day: /\d{2}/,
        }

        get 'time(/:year(/:month(/:day)))', to: 'days#index', constraints: {
          year: /\d{4}/,
          month: /\d{2}/,
          day: /\d{2}/,
        }
      end

      get 'users/:id', to: 'users#show'
      get 'myself', to: 'users#myself'

      post ':year/:month/:day', to: 'days#create', constraints: {
        year: /\d{4}/,
        month: /\d{2}/,
        day: /\d{2}/,
      }

      get '(:year(/:month(/:day)))', to: 'days#index', constraints: {
        year: /\d{4}/,
        month: /\d{2}/,
        day: /\d{2}/,
      }

    end
  end
end
