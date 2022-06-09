# frozen_string_literal: true

module Api
  module V1
    module System
      module Users
        class FindUseCase < ApplicationUseCase
          def initialize(params)
            super()

            @params = params
          end

          def call
            response(success: true, payload: find_user)
          rescue => error
            response(error:)
          end

          private

          attr_reader :params

          def find_user
            response = Api::V1::Github::FindUserService.call(connection:, username: params[:username])
            raise(response.error) unless response.success?

            response.payload
          end
        end
      end
    end
  end
end
