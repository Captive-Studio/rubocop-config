

# frozen_string_literal: true

Gem::Specification.new do |gem|
    gem.name = "captive-rubocop"
    gem.version = '1.0.0-alpha.0'
    gem.summary = "Shared rubocop configurations"
    gem.description = "Shared rubocop configuration for Captive projects"
    gem.authors = ["Captive", "Julien Polo", "Clément Prod'homme"]
    gem.email = ["julien.polo@captive.fr"]
    gem.homepage = "https://github.com/Captive-Studio/rubocop-config"
    gem.license = "MIT"
    gem.required_ruby_version = '>= 2.7'

    gem.files = Dir.chdir(File.expand_path(__dir__)) do
        `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
    end

    # gem.add_runtime_dependency 'relaxed-rubocop', '= 2.5'
    # gem.add_runtime_dependency 'rubocop', '= 1.30.1'
    # gem.add_runtime_dependency 'rubocop-rspec', '= 2.11.1'
end
