# frozen_string_literal: true

module Api
  module V1
    class RepositoriesController < ApplicationController
      def index
        response = Users::FindOrCreateUseCase.call(username: user_params)
        db_user = response.payload if response.success?

        Repositories::InsertAllUseCase.call(user: db_user)

        render json: db_user.repositories
      end

      private

      def user_params
        params.require(:user_id)
      end
    end
  end
end
