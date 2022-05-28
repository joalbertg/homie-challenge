# frozen_string_literal: true

module Api
  module V1
    module Repositories
      class SearchUseCase < ApplicationUseCase
        def initialize(params)
          super()

          @params = params
        end

        def call
          response(success: true, payload: search_repositories)
        rescue => error
          response(error:)
        end

        private

        attr_reader :params

        def search_repositories
          response = SearchService.call(user_id: params[:user_id], name: params[:name], full_name: params[:full_name])
          raise(response.error) unless response.success?

          response.payload
        end
      end
    end
  end
end
