# frozen_string_literal: true

module Api
  module V1
    module System
      module MemoryStorage
        class ApplicationStorageUseCase < ApplicationUseCase
          KEY_BASE = 'APP::Repository::'
          TTL = 1.hour

          private_constant :KEY_BASE
          private_constant :TTL
        end
      end
    end
  end
end
