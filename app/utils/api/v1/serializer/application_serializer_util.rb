# frozen_string_literal: true

module Api
  module V1
    module Serializer
      class ApplicationSerializerUtil < ApplicationUtil
        private

        def handler
          Oj
        end
      end
    end
  end
end
