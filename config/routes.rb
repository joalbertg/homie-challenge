# frozen_string_literal: true

require 'sidekiq/web'

# Configure Sidekiq-specific session middleware
Sidekiq::Web.use(ActionDispatch::Cookies)
Sidekiq::Web.use(Rails.application.config.session_store, Rails.application.config.session_options)

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'health_check', to: proc { [200, {}, ['success']] }

  namespace :api do
    namespace :v1 do
      resources :users, only: :show do
        resources :repositories, only: :index
      end
    end
  end
end
