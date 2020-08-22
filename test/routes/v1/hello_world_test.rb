# frozen_string_literal: true

require "test_helper"

class HelloWorldTest < ApiTest
  def test_get_hello_says_hello
    get "/api/v1/hello", {}.to_json
    assert last_response.ok?, "Response wasn't ok: " \
                              "#{last_response.body.inspect}."
    assert_equal({ message: "Hello World!" }.to_json, last_response.body, "WTF?")
  end
end
