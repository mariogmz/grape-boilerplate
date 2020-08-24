# frozen_string_literal: true

require_relative "jwt_methods"
require_relative "api_test"

class AuthenticatedApiTest < ApiTest
  include JwtMethods

  def setup
    super
    @request_headers = {
      "CONTENT_TYPE" => "application/json",
      "AUTHORIZATION" => "Bearer #{token}"
    }
    set_request_headers
    mock_jwt_authentication
  end

  private
    def set_request_headers
      @request_headers.each { |k, v| header(k, v) }
    end

    def mock_jwt_authentication
      Grape::Jwt::Authentication::Jwt.any_instance.stubs(:valid?).returns(true)
      JwtTokenService.stubs(:private_key).returns(rsa_private)
      JwtTokenService.stubs(:public_key).returns(rsa_public)
    end
end
