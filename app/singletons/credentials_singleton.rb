# frozen_string_literal: true

class CredentialsSingleton
  include Singleton
  attr_reader :secret

  class << self
    delegate :secret, to: :instance
  end

  private

  def initialize
    @secret = Rails.application.credentials
  rescue
    Rails.logger.error(error.message)
    raise(error)
  end
end
