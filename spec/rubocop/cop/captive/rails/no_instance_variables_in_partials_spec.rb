# frozen_string_literal: true

require "spec_helper"

describe RuboCop::Cop::Captive::Rails::NoInstanceVariablesInPartials do
  subject(:cop) { described_class.new }

  it "registers an offense when using an instance variable in a partial" do
    expect_offense(<<~RUBY)
      @variable
      ^^^^^^^^^ Captive/Rails/NoInstanceVariablesInPartials: Avoid using instance variables in partials.
    RUBY
  end

  it "does not register an offense when using a local variable in a partial" do
    expect_no_offenses(<<~RUBY)
      local_variable
    RUBY
  end
end
