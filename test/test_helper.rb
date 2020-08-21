# frozen_string_literal: true

require "rubygems"

ENV["RACK_ENV"] = "test"

require "rack/test"

require File.expand_path("../config/environment", __dir__)
Dir["./test/support/**/*"].each { |f| require f }

require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
