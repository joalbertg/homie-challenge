# frozen_string_literal: true

require 'credentials_singleton'

Rails.application.config.active_job.queue_adapter = :sidekiq

Sidekiq.configure_server do |config|
  config.redis = { url: CredentialsSingleton.secret.fetch(:redis_url, 'redis://localhost:6379/0') }
end

Sidekiq.configure_client do |config|
  config.redis = { url: CredentialsSingleton.secret.fetch(:redis_url, 'redis://localhost:6379/0') }
end
