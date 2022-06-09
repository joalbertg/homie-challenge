# frozen_string_literal: true

module Api
  module V1
    module System
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
            response = Api::V1::Users::CreateService.call(
              github_id: user['id'],
              url: user['html_url'],
              **build_attributes
            )
            raise(response.error) unless response.success?

            response.payload
          end

          def build_attributes
            user.slice(*%w[login name email avatar_url]).symbolize_keys
          end
        end
      end
    end
  end
end
