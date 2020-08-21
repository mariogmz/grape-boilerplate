# frozen_string_literal: true

module API
  class Root < Grape::API
    format :json
    default_format :json
    content_type :json, "application/json"

    rescue_from :grape_exceptions

    get "/" do
      "Hello world"
    end

    # Handle 404s
    route :any, "*path" do
      error!({ message: "The resource you're looking for does not exist" }, 404)
    end
  end
end
