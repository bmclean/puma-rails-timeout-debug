# frozen_string_literal: true

class Api::DemoController < ApplicationController
  def create
    Rails.logger.info "\e[36mReceived: #{params[:data].length}!\e[0m" if params[:data].present?
    head :ok
  end
end
