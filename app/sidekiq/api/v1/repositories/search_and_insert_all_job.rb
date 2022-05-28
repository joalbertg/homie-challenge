# frozen_string_literal: true

module Api
  module V1
    module Repositories
      class SearchAndInsertAllJob
        include Sidekiq::Job
        sidekiq_options queue: 'critical'

        def perform(user_id)
          @user_id = user_id

          insert_repositories
        end

        private

        attr_reader :user_id

        def user
          response = Users::FindService.call(id: user_id)
          raise(response.error) unless response.success?

          @user = response.payload
        end

        def insert_repositories
          InsertAllUseCase.call(user:)
        end
      end
    end
  end
end
