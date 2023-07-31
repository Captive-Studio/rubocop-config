# frozen_string_literal: true

require "spec_helper"

describe RuboCop::Cop::Captive::NoAppEnv do
  subject(:cop) { described_class.new }

  it 'flags usage of ENV["APP_ENV"]' do
    expect_offense(<<~RUBY)
      ENV['APP_ENV']
      ^^^^^^^^^^^^^^ Captive/NoAppEnv: #{RuboCop::Cop::Captive::NoAppEnv::MSG}

    RUBY
  end

  it 'flags usage of ENV.fetch("APP_ENV")' do
    expect_offense(<<~RUBY)
      ENV.fetch('APP_ENV', 'development')
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Captive/NoAppEnv: #{RuboCop::Cop::Captive::NoAppEnv::MSG}
    RUBY
  end

  it "does not flag usage of Rails.env" do
    expect_no_offenses(<<~RUBY)
      Rails.env
    RUBY
  end

  it "does not flag usage of other ENV variables" do
    expect_no_offenses(<<~RUBY)
      ENV['SOME_OTHER_VAR']
    RUBY
  end
end
