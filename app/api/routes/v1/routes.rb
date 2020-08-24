# frozen_string_literal: true

module Routes
  module V1
    class API < Grape::API
      prefix :api
      version "v1"

      # Authentication
      include Grape::Jwt::Authentication
      auth :jwt

      resource :hello do
        get do
          { message: "Hello World!" }
        end
      end
    end
  end
end
