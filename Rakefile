#!/usr/bin/env rake
# frozen_string_literal: true

require "rubygems"
require "bundler"

ENV["RAKE_ENV"] ||= "development"

begin
  Bundler.setup :default, ENV["RACK_ENV"]
rescue Bundler::BundlerError => e
  warn e.message
  warn "Run `bundle install` to install missing gems"
  exit e.status_code
end

require "rake"

# Loads whole app for any other tasks
task :environment do
  require File.expand_path("config/environment.rb", __dir__)
end

# Shows app routes
task routes: :environment do
  API::Root.routes.each do |route|
    method = route.request_method.ljust(10)
    path = route.origin
    puts "      #{method} #{path}"
  end
end

require "rake/testtask"
Rake::TestTask.new do |task|
  task.libs << "test"
  task.test_files = FileList["test/**/*_test.rb"]
  task.verbose = false
  task.warning = false
end

require "rubocop/rake_task"
RuboCop::RakeTask.new(:rubocop)

task default: %i[rubocop test]
