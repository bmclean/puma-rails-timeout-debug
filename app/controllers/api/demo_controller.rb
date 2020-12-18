# frozen_string_literal: true

class Api::DemoController < ApplicationController
  def create
    sleep Float(ENV["EXAMPLE_SLEEP_TIME"] || 0 )
    Rails.logger.info "\e[36mReceived: #{params[:data].length}!\e[0m" if params[:data].present?
    render json: "Got it!", status: :ok
  end
end
