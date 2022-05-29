# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from(Exception) do |exception|
    Rails.logger.error(exception)
    render(json: { error: exception }, status: :internal_server_error)
  end

  rescue_from(ActiveRecord::RecordNotFound) do |exception|
    Rails.logger.error(exception)
    render(json: { error: exception }, status: :not_found)
  end
end
