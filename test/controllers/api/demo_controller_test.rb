# frozen_string_literal: true

require "test_helper"

class Api::DemoControllerTest < ActionDispatch::IntegrationTest
  test "create" do
    data = "g5yDXwDAewMAAA+dg18AQHwDAAAAAAIA/QmF0dGVyeSBGdWxsH2l1LDQfV2hpdGUgaVBhZCBBaXIgMhU9THzEz"
    params = { data: data }
    post api_demo_index_url, params: params
    assert_response :success
  end
end
