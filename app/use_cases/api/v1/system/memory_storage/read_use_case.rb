# frozen_string_literal: true

module Api
  module V1
    module System
      module MemoryStorage
        class ReadUseCase < ApplicationStorageUseCase
          def initialize(params)
            super()

            @params = params
          end

          def call
            response(success: true, payload: read_value)
          rescue => error
            response(error:)
          end

          private

          attr_reader :params

          def read_value
            response = Api::V1::MemoryStorage::ReadService.call(build_params)
            raise(response.error) unless response.success?

            response.payload
          end

          def build_params
            { key: "#{KEY_BASE}#{params[:key]}" }
          end
        end
      end
    end
  end
end
