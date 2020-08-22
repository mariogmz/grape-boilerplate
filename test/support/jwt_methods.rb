# frozen_string_literal: true

module JwtMethods
  def payload
    @payload ||= {
      "name" => "John Doe",
      "email" => "john.doe@test.com"
    }
  end

  def token(custom_payload = nil)
    JWT.encode(custom_payload || payload, rsa_private, "RS256")
  end

  def rsa_private
    @rsa_private ||= OpenSSL::PKey::RSA.generate(2048)
  end

  def rsa_public
    @rsa_public ||= rsa_private.public_key
  end
end
