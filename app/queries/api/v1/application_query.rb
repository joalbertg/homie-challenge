# frozen_string_literal: true

module Api
  module V1
    class ApplicationQuery
      def self.call(*args, &)
        new(*args, &).call
      end

      private

      def response(success: false, payload: {}, error: nil)
        Struct.new('Response', :success?, :payload, :error) unless Struct.const_defined?(:Response)
        Struct::Response.new(success, payload, error)
      end
    end
  end
end
