# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

%w[api models services].each do |folder|
  $LOAD_PATH.unshift(File.expand_path("../app/#{folder}", __dir__))
end

require "boot"
require "byebug" unless Env.production?

Bundler.require :default, Env.rack

Config.load_and_set_settings(
  Config.setting_files(File.dirname(__FILE__), Env.rack)
)

Dir[File.expand_path("./initializers/*.rb", __dir__)].each { |f| require f }

Dir[File.expand_path("../app/**/*.rb", __dir__)].sort.each do |file|
  require file
end
