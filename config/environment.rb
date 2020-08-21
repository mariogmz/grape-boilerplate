# frozen_string_literal: true

ENV["RACK_ENV"] ||= "development"

module Env
  class << self
    def rack
      ENV["RACK_ENV"]
    end

    %w[development test production].each do |environment|
      define_method "#{environment}?" do
        rack === environment
      end
    end
  end
end

require File.expand_path("application", __dir__)
