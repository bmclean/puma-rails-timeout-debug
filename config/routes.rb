# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :api, as: :api, defaults: {format: "json"} do
    resources :demo, only: [:create]
  end
end
