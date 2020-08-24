# frozen_string_literal: true

module API
  class Root < Grape::API
    format :json
    default_format :json
    content_type :json, "application/json"

    rescue_from :grape_exceptions

    # Logging
    logger ApiLogger.new

    # Helpers
    helpers do
      include Helpers
    end

    # Middleware
    unless Env.test?
      use GrapeLogging::Middleware::RequestLogger,
          logger: logger,
          include: [GrapeLogging::Loggers::FilterParameters.new([:password])]
    end

    # Routes
    mount Routes::Session
    mount Routes::V1

    add_swagger_documentation

    # Handle 404s
    route :any, "*path" do
      error!({ message: "The resource you're looking for does not exist" }, 404)
    end
  end
end
