# frozen_string_literal: true

require "spec_helper"

describe RuboCop::Cop::Captive::Rails::ForceSslEnabledInProduction do
  subject(:cop) { described_class.new }

  it "registers an offense when force_ssl is commented out" do
    expect_offense(<<~RUBY)
      # config.force_ssl = true
      ^^^^^^^^^^^^^^^^^^^^^^^^^ Captive/Rails/ForceSslEnabledInProduction: force_ssl should be enabled in production.
    RUBY
  end

  it "registers an offense when force_ssl is set to false" do
    expect_offense(<<~RUBY)
      config.force_ssl = false
      ^^^^^^^^^^^^^^^^^^^^^^^^ Captive/Rails/ForceSslEnabledInProduction: force_ssl should be enabled in production.
    RUBY
  end

  it "does not register an offense when force_ssl is tied to an env var" do
    expect_no_offenses(<<~RUBY)
      config.force_ssl = ENV["SKIP_FORCE_SSL"].blank?
    RUBY
  end

  it "registers an offense when force_ssl is set dynamically" do
    expect_offense(<<~RUBY)
      config.force_ssl = ENV['RAILS_FORCE_SSL'].present?
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Captive/Rails/ForceSslEnabledInProduction: force_ssl should be enabled in production.
    RUBY
  end
end
