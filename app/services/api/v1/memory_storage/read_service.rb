# frozen_string_literal: true

module Api
  module V1
    module MemoryStorage
      class ReadService < ApplicationStorageService
        def initialize(params)
          super()

          @params = params
        end

        def call
          response(success: true, payload: read)
        rescue
          response(error: StandardError.new(self))
        end

        private

        attr_reader :params

        def read
          handler.get(params[:key])
        end
      end
    end
  end
end
