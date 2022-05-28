# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def show
        response = Users::FindOrCreateUseCase.call(username: user_params)
        user = response.payload if response.success?

        Repositories::SearchAndInsertAllJob.perform_async(user.id)
        render json: user.as_json
      end

      private

      def user_params
        params.require(:id)
      end
    end
  end
end
