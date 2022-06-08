# frozen_string_literal: true

require 'credentials_singleton'

Rails.application.configure do
  config.cache_store =
    :redis_cache_store,
    { url: CredentialsSingleton.secret.fetch(:redis_url, 'redis://localhost:6379/0') }
end
