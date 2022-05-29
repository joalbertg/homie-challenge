# frozen_string_literal: true

require 'sidekiq/web'

# Configure Sidekiq-specific session middleware
Sidekiq::Web.use(ActionDispatch::Cookies)
Sidekiq::Web.use(Rails.application.config.session_store, Rails.application.config.session_options)

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount Sidekiq::Web => '/sidekiq'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'health_check', to: proc { [200, { 'content-type' => 'application/json' }, [{ success: :ok }.to_json]] }

  namespace :api do
    namespace :v1 do
      resources :users, only: :show do
        resources :repositories, only: :index do
          collection do
            get :search
          end
        end
      end

      get 'repositories/search'
    end
  end

  match(
    '*path', to: proc { [404, { 'content-type' => 'application/json' }, [{ error: :not_found }.to_json]] }, via: :all
  )
end
