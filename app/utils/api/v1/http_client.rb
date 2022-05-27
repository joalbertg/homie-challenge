# frozen_string_literal: true

module Api
  module V1
    class HttpClient < ApplicationUtil
      def initialize(params = {})
        super()

        @params = params
      end

      def call
        response(success: true, payload: request)
      rescue
        response(error: StandardError.new(self))
      end

      private

      attr_reader :params

      def request
        Faraday.new do |f|
          f.request :authorization, 'Bearer', params[:token] if params[:token]
          # encode req bodies as JSON
          f.request(:json)
          # retry transient failures
          f.request(:retry)
          # follow redirects
          f.response(:follow_redirects)
          # decode response bodies as JSON
          f.response(:json)
        end
      end
    end
  end
end
