# frozen_string_literal: true

module Api
  module V1
    module Users
      class FindQuery < ApplicationQuery
        attr_accessor :params

        def initialize(scope = User.all)
          @scope = scope
          yield(self) if block_given?

          @params = params || {}
        end

        def call
          response(success: true, payload: find_user)
        rescue
          response(error: StandardError.new(self))
        end

        private

        attr_reader :params, :scope

        def find_user
          @scope = scope.with_id(params[:id]) if params[:id]
          @scope = scope.with_login(params[:login]) if params[:login]
          @scope = scope.with_github_id(params[:github_id]) if params[:github_id]
          scope.limit(1).first
        end
      end
    end
  end
end
