Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'auth/slack', to: 'sessions#create'

      resources :clients do
        resources :projects, shallow: true
      end

      resources :users, only: [:index, :show] do
        get 'weekday_settings', to: 'weekday_settings#index'
        put 'weekday_settings', to: 'weekday_settings#update_all'

        post 'days/:year/:month/:day', to: 'days#create_or_update', constraints: {
          year: /\d{4}/,
          month: /\d{2}/,
          day: /\d{2}/,
        }

        get 'days/:year/:month/:day', to: 'days#show', constraints: {
          year: /\d{4}/,
          month: /\d{2}/,
          day: /\d{2}/,
        }

        resources :days, only: [:index]
      end

      get 'myself', to: 'users#myself'
      get 'weekday_settings', to: 'weekday_settings#index'

      post ':year/:month/:day', to: 'days#create_or_update', constraints: {
        year: /\d{4}/,
        month: /\d{2}/,
        day: /\d{2}/,
      }

      get ':year/:month/:day', to: 'days#show', constraints: {
        year: /\d{4}/,
        month: /\d{2}/,
        day: /\d{2}/,
      }

      get 'slack', to: 'slack#trigger'

      root to: 'days#index'
    end
  end
end
