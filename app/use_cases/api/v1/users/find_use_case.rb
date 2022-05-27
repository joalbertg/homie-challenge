# frozen_string_literal: true

module Api
  module V1
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
          response = Github::FindUserService.call(connection: , username: params[:username])
          reise(response.error) unless response.success?

          response.payload
        end
      end
    end
  end
end
