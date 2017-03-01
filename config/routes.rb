Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' },
    defaults: { format: :json }

  namespace :api do
    namespace :v1 do
      resources :projects

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
