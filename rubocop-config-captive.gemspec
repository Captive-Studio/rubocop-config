# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "rubocop/captive/version"

Gem::Specification.new do |gem|
  gem.name = "rubocop-config-captive"
  gem.version = RuboCop::Captive::VERSION
  gem.summary = "Shared rubocop configurations"
  gem.description = "Shared rubocop configuration for Captive projects"
  gem.authors = ["Captive", "Julien Polo", "Clément Prod'homme"]
  gem.email = ["julien.polo@captive.fr"]
  gem.homepage = "https://github.com/Captive-Studio/rubocop-config"
  gem.license = "MIT"
  gem.required_ruby_version = ">= 2.6"

  gem.files = Dir[
    "{config,lib}/**/*",
    "*.md",
    "*.gemspec",
    "Gemfile",
  ]

  gem.add_dependency("rubocop", "~> 1.77.0")
  gem.add_dependency("rubocop-performance", "~> 1.25.0")
  gem.add_dependency("rubocop-rake", "~> 0.7.1")
  gem.add_dependency("rubocop-rails", "~> 2.32.0")
  gem.add_dependency("rubocop-rspec", "~> 3.6.0")
  gem.add_dependency("rubocop-capybara", "~> 2.22.1")
  gem.add_dependency("rubocop-factory_bot", "~> 2.27.1")
  gem.add_dependency("rubocop-magic_numbers", "~> 0.5.0")
  gem.add_dependency("rubocop-rails-omakase", "~> 1.1.0")
  gem.add_development_dependency("rspec", "~> 3.12")
end
