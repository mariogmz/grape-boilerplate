# frozen_string_literal: true

require File.expand_path("config/environment", __dir__)

use Rack::Cors do
  allow do
    origins "*"
    resource "*", headers: :any, methods: :any
  end
end

run API::Root
