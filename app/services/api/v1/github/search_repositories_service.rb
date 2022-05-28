# frozen_string_literal: true

module Api
  module V1
    module Github
      class SearchRepositoriesService < ApplicationService
        def initialize(params)
          super()

          @params = params
          @connection = params[:connection]
          @options = params[:options] || {}
        end

        def call
          response(success: true, payload: search_repositories)
        rescue
          response(error: StandardError.new(self))
        end

        private

        attr_reader :params, :connection, :options

        URL = 'https://api.github.com/users/'

        def search_repositories
          response = connection.get("#{URL}#{params[:username]}/repos", options)
          raise unless response.status.in?(200..299)

          response.body
        end
      end
    end
  end
end
