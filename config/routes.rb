Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'auth/slack', to: 'sessions#create'

      resources :projects

      resources :users, only: [:index] do
        get 'weekday_settings', to: 'weekday_settings#index'
        put 'weekday_settings', to: 'weekday_settings#update_all'

        post ':year/:month/:day', to: 'days#create_or_update', constraints: {
          year: /\d{4}/,
          month: /\d{2}/,
          day: /\d{2}/,
        }

        get '(/:year(/:month(/:day)))', to: 'days#index', constraints: {
          year: /\d{4}/,
          month: /\d{2}/,
          day: /\d{2}/,
        }
      end

      get 'users/:id', to: 'users#show'
      get 'myself', to: 'users#myself'
      get 'weekday_settings', to: 'weekday_settings#index'

      post ':year/:month/:day', to: 'days#create_or_update', constraints: {
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
