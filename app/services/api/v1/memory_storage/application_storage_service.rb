# frozen_string_literal: true

module Api
  module V1
    module MemoryStorage
      class ApplicationStorageService < ApplicationService
        private

        def handler
          RedisSingleton.redis
        end
      end
    end
  end
end
