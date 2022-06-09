# frozen_string_literal: true

module Api
  module V1
    module System
      module MemoryStorage
        module Users
          class FindOrCreateUseCase < ApplicationStorageUseCase
            def initialize(params)
              super()

              @params = params
            end

            def call
              response(success: true, payload: find_or_create_user)
            rescue => error
              response(error:)
            end

            private

            attr_reader :params

            def find_or_create_user
              user = find_user
              return create_user if user.nil?

              user
            end

            def find_user
              response = MemoryStorage::ReadUseCase.call(key: build_key)
              raise(response.error) unless response.success?
              return if response.payload.nil?

              hash_user = load(response.payload)
              Rails.logger.info('rescued from cache...')

              hash_to_active_record(hash_user)
            end

            def create_user
              response = Api::V1::Users::FindOrCreateUseCase.call(username: params[:username])
              raise(response.error) unless response.success?

              MemoryStorage::WriteWithTtlUseCase.call { |cache| cache.params = build_params(response.payload) }
              Rails.logger.info('caching...')
              find_user
            end

            def build_params(user)
              {
                key: build_key,
                value: dump(user)
              }
            end

            def build_key
              "user:#{params[:username]}"
            end

            def load(user)
              response = Serializer::LoadUtil.call(value: user)
              raise(response.error) unless response.success?

              response.payload
            end

            def dump(user)
              response = Serializer::DumpUtil.call(value: user.as_json)
              raise(response.error) unless response.success?

              response.payload
            end

            def hash_to_active_record(user_hash)
              User.new(JSON.parse(user_hash.to_json))
            end
          end
        end
      end
    end
  end
end
