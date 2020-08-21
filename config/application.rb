# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

%w[api models services].each do |folder|
  $LOAD_PATH.unshift(File.expand_path("../app/#{folder}", __dir__))
end

require "boot"
require "byebug" if %w[development test].include? ENV["RACK_ENV"]

Bundler.require :default, ENV["RACK_ENV"]

Dir[File.expand_path("../app/**/*.rb", __dir__)].sort.each do |file|
  require file
end
