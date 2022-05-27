# frozen_string_literal: true

module Api
  module V1
    module Users
      class CreateUseCase < ApplicationUseCase
        def initialize(params)
          super()

          @params = params
          @user = params[:user]
        end

        def call
          response(success: true, payload: create_user)
        rescue => error
          response(error:)
        end

        private

        attr_reader :params, :user

        def create_user
          response = Users::CreateService.call(
            github_id: user['id'],
            login: user['login'],
            url: user['html_url'],
            name: user['name'],
            email: user['email'],
            avatar_url: user['avatar_url']
          )
          raise(response.error) unless response.success?

          response.payload
        end
      end
    end
  end
end
