# frozen_string_literal: true

module Api
  module V1
    module System
      module MemoryStorage
        class WriteWithTtlUseCase < ApplicationStorageUseCase
          attr_accessor :params

          def initialize
            super()
            yield(self) if block_given?
          end

          def call
            response(success: true, payload: write_value)
          rescue => error
            response(error:)
          end

          private

          def write_value
            response = Api::V1::MemoryStorage::WriteTtlService.call(build_params)
            raise(response.error) unless response.success?

            response.payload
          end

          def build_params
            {
              key: "#{KEY_BASE}#{params[:key]}",
              seconds: ttl,
              value: params[:value]
            }
          end

          def ttl
            params[:seconds] || TTL
          end
        end
      end
    end
  end
end
