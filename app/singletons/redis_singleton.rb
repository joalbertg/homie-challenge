# frozen_string_literal: true

class RedisSingleton
  include Singleton
  attr_reader :redis

  class << self
    delegate :redis, to: :instance
  end

  private

  def initialize
    uri = URI.parse(ENV.fetch('REDIS_URL', 'redis://localhost:6379/0'))
    @redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)

    Rails.logger.info("PING: #{redis.ping}")
  rescue
    Rails.logger.error(error.message)
    raise(error)
  end
end
