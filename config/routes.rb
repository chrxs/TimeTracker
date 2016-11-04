Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :projects
      resources :users do
        resources :days do
          resources :time_records
        end
      end

    end
  end
end
