# frozen_string_literal: true

module Api
  module V1
    module Users
      class FindQuery < ApplicationQuery
        attr_accessor :params

        def initialize(scope = User.all)
          super()

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

        attr_reader :scope

        def find_user
          @scope = with_id
          @scope = with_login
          @scope = with_github_id

          scope.limit(1).first
        end

        def with_id
          id = params[:id]
          return scope unless id

          scope.with_id(id)
        end

        def with_login
          login = params[:login]
          return scope unless login

          scope.with_login(login)
        end

        def with_github_id
          github_id = params[:github_id]
          return scope unless github_id

          scope.with_github_id(github_id)
        end
      end
    end
  end
end
