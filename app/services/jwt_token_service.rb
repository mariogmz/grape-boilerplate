# frozen_string_literal: true

class JwtTokenService
  ALGORITHM = "RS256"
  CLAIMS = {
    iss: Settings.jwt.issuer,
    aud: Settings.jwt.beholder
  }.freeze
  LEEWAY = 30

  def encode(payload)
    JWT.encode(prepare_payload(payload), private_key, ALGORITHM, typ: "JWT")
  end

  def decode(token)
    JWT.decode(token, public_key, true, exp_leeway: LEEWAY, algorithm: ALGORITHM)
  end

  private
    def private_key
      return key_from_env(:private) if Settings.jwt.private_key
      path = Settings.jwt.private_key_path
      OpenSSL::PKey::RSA.new(File.read(path))
    end

    def public_key
      return key_from_env(:private) if Settings.jwt.public_key
      path = Settings.jwt.public_key_url
      OpenSSL::PKey::RSA.new(File.read(path))
    end

    def prepare_payload(payload)
      minutes = Settings.jwt.expiration_time_minutes.to_i
      time = Time.now.to_i + minutes * 3600
      payload[:exp] = time
      payload.merge(CLAIMS)
    end

    def key(setting)
      OpenSSL::PKey::RSA.new({
        private: Settings.jwt.private_key,
        public: Settings.jwt.public_key
      }[setting])
    end
end
