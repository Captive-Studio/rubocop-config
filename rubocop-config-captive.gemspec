# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name = 'rubocop-config-captive'
  gem.version = '1.0.0-alpha.0'
  gem.summary = 'Shared rubocop configurations'
  gem.description = 'Shared rubocop configuration for Captive projects'
  gem.authors = ['Captive', 'Julien Polo', "Clément Prod'homme"]
  gem.email = ['julien.polo@captive.fr']
  gem.homepage = 'https://github.com/Captive-Studio/rubocop-config'
  gem.license = 'MIT'
  gem.required_ruby_version = '>= 2.5'

  gem.files = Dir[
    '{conf,lib}/**/*',
    '*.md',
    '*.gemspec',
    'Gemfile',
  ]

  # It is not clear what the level of support is provided by Airbnb
  # ⚠️ Instead of depending on rubocop-airbnb we copy sources
  #
  # gem.add_dependency('rubocop-airbnb', '~> 4.0.0')
  gem.add_dependency('rubocop', '~> 1.45.0')
  gem.add_dependency('rubocop-performance', '~> 1.10.2')
  gem.add_dependency('rubocop-rails', '~> 2.9.1')
  gem.add_dependency('rubocop-rspec', '~> 2.0.0')
  gem.add_development_dependency('rspec', '~> 3.5')
  # gem.metadata['rubygems_mfa_required'] = 'true'
end
