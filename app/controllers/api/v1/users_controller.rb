# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def show
        response = Users::FindOrCreateUseCase.call(username: user_params)
        db_user = response.payload if response.success?

        render json: db_user.as_json
      end

      private

      def user_params
        params.require(:id)
      end
    end
  end
end
