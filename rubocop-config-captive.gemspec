# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name = 'ruboco-config-captive'
  gem.version = '1.0.0-alpha.0'
  gem.summary = 'Shared rubocop configurations'
  gem.description = 'Shared rubocop configuration for Captive projects'
  gem.authors = ['Captive', 'Julien Polo', "Clément Prod'homme"]
  gem.email = ['julien.polo@captive.fr']
  gem.homepage = 'https://github.com/Captive-Studio/rubocop-config'
  gem.license = 'MIT'
  gem.required_ruby_version = '>= 2.7'

  gem.files = Dir[
    '{conf,lib}/**/*',
    '*.md',
    '*.gemspec',
    'Gemfile',
  ]

  gem.add_dependency('rubocop-airbnb', '~> 4.0.0')

  gem.add_development_dependency 'bundler', '~> 2.0'
  gem.add_development_dependency 'rake', '~> 12.3'
  # gem.metadata['rubygems_mfa_required'] = 'true'
end
