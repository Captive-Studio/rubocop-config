require "pathname"
require "yaml"

# Load original rubocop gem
require "rubocop"

require "rubocop-performance"
require "rubocop-rails"

require "rubocop/captive"
require "rubocop/captive/inject"
require "rubocop/captive/version"

RuboCop::Captive::Inject.defaults!
