# frozen_string_literal: true

Rails.application.routes.draw do
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
