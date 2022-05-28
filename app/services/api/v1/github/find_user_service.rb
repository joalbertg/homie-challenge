# frozen_string_literal: true

module Api
  module V1
    module Github
      class FindUserService < ApplicationService
        def initialize(params)
          super()

          @params = params
          @connection = params[:connection]
        end

        def call
          response(success: true, payload: find_user)
        rescue
          response(error: StandardError.new(self))
        end

        private

        attr_reader :params, :connection

        URL = 'https://api.github.com/users/'

        def find_user
          response = connection.get("#{URL}#{params[:username]}")
          raise unless response.status.in?(200..299)

          response.body
        end
      end
    end
  end
end
