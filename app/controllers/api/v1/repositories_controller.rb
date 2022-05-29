# frozen_string_literal: true

module Api
  module V1
    class RepositoriesController < ApplicationController
      def index
        Repositories::InsertAllUseCase.call(user:)

        render(json: { repositories: user.repositories })
      end

      def search
        response = Repositories::SearchUseCase.call(
          user_id: user&.id,
          name: repository_params[:name],
          full_name: repository_params[:full_name]
        )
        repositories = response.payload if response.success?

        render(json: { repositories: })
      end

      private

      def repository_params
        params.permit(:user_id, :name, :full_name)
      end

      def user_param
        return params.require(:user_id) unless params[:action] == 'search'

        repository_params[:user_id]
      end

      def user
        return @user if defined?(@user)

        response = Users::FindOrCreateUseCase.call(username: user_param)
        @user = response.payload if response.success?
      end
    end
  end
end
