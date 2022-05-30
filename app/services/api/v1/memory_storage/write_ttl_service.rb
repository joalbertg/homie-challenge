# frozen_string_literal: true

module Api
  module V1
    module MemoryStorage
      class WriteTtlService < ApplicationStorageService
        def initialize(params)
          super()

          @params = params
        end

        def call
          response(success: true, payload: write_ttl)
        rescue
          response(error: StandardError.new(self))
        end

        private

        attr_reader :params

        def write_ttl
          handler.setex(params[:key], params[:seconds], params[:value])
        end
      end
    end
  end
end
