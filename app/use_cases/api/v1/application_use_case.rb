# frozen_string_literal: true

module Api
  module V1
    class ApplicationUseCase
      def self.call(*args, &)
        new(*args, &).call
      end

      private

      def response(success: false, payload: {}, error: nil)
        Struct.new('Response', :success?, :payload, :error) unless Struct.const_defined?(:Response)
        Struct::Response.new(success, payload, error)
      end

      def connection
        response = HttpClient.call(token: Figaro.env.GITHUB_TOKEN)
        raise(resul.error) unless response.success?

        response.payload
      end
    end
  end
end
