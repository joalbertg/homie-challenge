# frozen_string_literal: true

module Api
  module V1
    module Repositories
      class InsertAllService < V1::ApplicationService
        def initialize(params)
          super()

          @params = params
        end

        def call
          response(success: true, payload: insert_all)
        rescue
          response(error: StandardError.new(self))
        end

        private

        attr_reader :params

        def insert_all
          Repository.upsert_all(params[:repositories], unique_by: :repository_id)
        end
      end
    end
  end
end
