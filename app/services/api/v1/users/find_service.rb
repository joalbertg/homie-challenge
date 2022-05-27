# frozen_string_literal: true

module Api
  module V1
    module Users
      class FindService < V1::ApplicationService
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
          User.find_by(github_id: params[:github_id])
        end
      end
    end
  end
end
