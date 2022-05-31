# frozen_string_literal: true

module Api
  module V1
    module Repositories
      class SearchService < ApplicationService
        def initialize(params)
          super()

          @params = params
        end

        def call
          response(success: true, payload: search_repositories.page(params[:page]).per(params[:per_page]))
        rescue
          response(error: StandardError.new(self))
        end

        private

        attr_reader :params

        def search_repositories
          response = SearchQuery.call { |repository| repository.params = { **params } }
          raise(response.error) unless response.success?

          response.payload
        end
      end
    end
  end
end
