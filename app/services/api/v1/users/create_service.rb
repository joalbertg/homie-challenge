# frozen_string_literal: true

module Api
  module V1
    module Users
      class CreateService < ApplicationService
        def initialize(params)
          super()

          @params = params
        end

        def call
          response(success: true, payload: create_user)
        rescue
          response(error: StandardError.new(self))
        end

        private

        attr_reader :params

        def create_user
          User.create(
            github_id: params[:github_id],
            login: params[:login],
            url: params[:url],
            name: params[:name],
            email: params[:email],
            avatar_url: params[:avatar_url]
          )
        end
      end
    end
  end
end
