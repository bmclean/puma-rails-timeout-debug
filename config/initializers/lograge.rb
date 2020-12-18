# frozen_string_literal: true

Rails.application.configure do
  config.lograge.base_controller_class = ["ActionController::API"]
  config.lograge.enabled = true
end
