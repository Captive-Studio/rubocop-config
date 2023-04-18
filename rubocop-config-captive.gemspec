# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'rubocop/captive/version'

Gem::Specification.new do |gem|
  gem.name = 'rubocop-config-captive'
  gem.version = RuboCop::Captive::VERSION
  gem.summary = 'Shared rubocop configurations'
  gem.description = 'Shared rubocop configuration for Captive projects'
  gem.authors = ['Captive', 'Julien Polo', "Clément Prod'homme"]
  gem.email = ['julien.polo@captive.fr']
  gem.homepage = 'https://github.com/Captive-Studio/rubocop-config'
  gem.license = 'MIT'
  gem.required_ruby_version = '>= 2.5'

  gem.files = Dir[
    '{config,lib}/**/*',
    '*.md',
    '*.gemspec',
    'Gemfile',
  ]

  # It is not clear what the level of support is provided by Airbnb
  # ⚠️ Instead of depending on rubocop-airbnb we copy sources
  #
  # gem.add_dependency('rubocop-airbnb', '~> 4.0.0')
  gem.add_dependency('rubocop', '~> 1.49.0')
  gem.add_dependency('rubocop-performance', '~> 1.16.0 ')
  gem.add_dependency('rubocop-rake', '~> 0.6.0')
  gem.add_dependency('rubocop-rails', '~> 2.18.0')
  gem.add_dependency('rubocop-rspec', '~> 2.19.0')
  gem.add_dependency('rubocop-capybara', '~> 2.17.1')
  gem.add_development_dependency('rspec', '~> 3.12')
  # gem.metadata['rubygems_mfa_required'] = 'true'
end
