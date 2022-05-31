# frozen_string_literal: true

module Api
  module V1
    class RepositoriesController < ApplicationController
      def index
        Repositories::InsertAllUseCase.call(user:)
        raise(ActiveRecord::RecordNotFound) if user.nil?

        render(json: { repositories: user.repositories.page(params[:page]).per(params[:per_page]) })
      end

      def search
        response = Repositories::SearchUseCase.call(
          user_id: user&.id,
          name: repository_params[:name],
          full_name: repository_params[:full_name],
          page: repository_params[:page],
          per_page: repository_params[:per_page]
        )
        raise(response.error) unless response.success?

        render(json: { repositories: response.payload })
      end

      private

      def repository_params
        params.permit(:user_id, :name, :full_name, :page, :per_page)
      end

      def user_params
        return params.require(:user_id) unless params[:action] == 'search'

        repository_params[:user_id]
      end

      def user
        return @user if defined?(@user)

        response = MemoryStorage::Users::FindOrCreateUseCase.call(username: user_params)
        @user = hash_to_active_record(response.payload) if response.success?
      end

      def hash_to_active_record(user_hash)
        return user_hash if user_hash.is_a?(User)

        User.new(JSON.parse(user_hash.to_json))
      end
    end
  end
end
