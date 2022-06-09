# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def show
        response = System::MemoryStorage::Users::FindOrCreateUseCase.call(username: user_params)

        if response.success?
          user = response.payload

          Repositories::SearchAndInsertAllJob.perform_async(user['id'])
          render(json: user)
        else
          render(json: { error: response.error }, status: :not_found)
        end
      end

      private

      def user_params
        params.require(:id)
      end
    end
  end
end
