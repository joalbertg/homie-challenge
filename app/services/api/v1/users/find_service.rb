# frozen_string_literal: true

module Api
  module V1
    module Users
      class FindService < ApplicationService
        def initialize(params)
          super()

          @params = params
        end

        def call
          response(success: true, payload: find_user)
        rescue
          response(error: StandardError.new(self))
        end

        private

        attr_reader :params

        def find_user
          response = FindQuery.call { |user| user.params = { **params } }
          raise(response.error) unless response.success?

          response.payload
        end
      end
    end
  end
end
