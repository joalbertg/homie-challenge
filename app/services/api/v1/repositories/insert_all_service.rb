# frozen_string_literal: true

module Api
  module V1
    module Repositories
      class InsertAllService < ApplicationService
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
          Repository.upsert_all(check_fields!, unique_by: :repository_id)
        end

        def check_fields!
          params[:repositories].map do |repository|
            unless repository[:fork].is_a?(String)
              repository[:fork] = repository[:fork] ? 't' : 'f'
            end
            repository
          end
        end
      end
    end
  end
end
