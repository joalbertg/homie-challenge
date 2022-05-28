# frozen_string_literal: true

module Api
  module V1
    module Repositories
      class SearchQuery < ApplicationQuery
        attr_accessor :params

        def initialize(scope = Repository.all)
          super()

          @scope = scope
          yield(self) if block_given?

          @params = params || {}
        end

        def call
          response(success: true, payload: search_repositories)
        rescue
          response(error: StandardError.new(self))
        end

        private

        attr_reader :scope

        def search_repositories
          @scope = with_name
          @scope = with_full_name
          @scope = with_user_id
          scope
        end

        def has_where?
          @scope.to_sql.downcase.include?('where')
        end

        def with_name
          name = params[:name]

          return scope unless name
          return scope.or(Repository.with_full_name(name)) if has_where?

          scope.with_name(name)
        end

        def with_full_name
          full_name = params[:full_name]

          return scope unless full_name
          return scope.or(Repository.with_full_name(full_name)) if has_where?

          scope.with_full_name(full_name)
        end

        def with_user_id
          user_id = params[:user_id]
          return scope unless user_id

          scope.joins(:user).with_user_id(user_id)
        end
      end
    end
  end
end
