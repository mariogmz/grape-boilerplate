# frozen_string_literal: true

Grape::Jwt::Authentication.configure do |config|
  # RSA configurations
  config.rsa_public_key_url = Settings.jwt.public_key_url

  # JWT Wrapper
  config.jwt_issuer = Settings.jwt.issuer
  config.jwt_beholder = Settings.jwt.beholder

  # Let Grape handle the malformed error with correct response formatting.
  # (XML, JSON)
  config.malformed_auth_handler = proc do
    response_body = {
      status: 'failure',
      message: 'Authentication token missing or malformed'
    }.to_json
    [401, { 'Content-Type' => 'application/json' }, [response_body]]
  end

  # The same procedure for failed verifications. (XML, JSON formatting handled
  # external by Grape)
  config.failed_auth_handler = proc do
    response_body = {
      status: 'failure',
      message: 'Unauthorized access'
    }.to_json
    [403, { 'Content-Type' => 'application/json' }, [response_body]]
  end

  # Custom verification logic.
  config.authenticator = proc do |token|
    # Parse and instantiate a JWT verification instance
    jwt = Grape::Jwt::Authentication::Jwt.new(token)
    # We just allow valid JWT tokens
    jwt.valid?
  end
end
