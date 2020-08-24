# frozen_string_literal: true

module API::Routes
  class V1 < Grape::API
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
