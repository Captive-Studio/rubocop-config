# frozen_string_literal: true

require "spec_helper"

RSpec.describe RuboCop::Cop::Captive::RSpec::SpecifyBeforeParameter, :config do
  subject(:cop) { described_class.new(config) }

  it "registers an offense when `before` is used without a parameter" do
    expect_offense(<<~RUBY)
      before do
      ^^^^^^^^^ Specify the parameter in `before` blocks. Example : before(:each) or before(:all)
        # some code
      end
    RUBY

    expect_correction(<<~RUBY)
      before(:each) do
        # some code
      end
    RUBY
  end

  it "does not register an offense when `before` is used with a parameter" do
    expect_no_offenses(<<~RUBY)
      before(:all) do
        # some code
      end
    RUBY
  end

  it "does not register an offense when `before` is used with multiple parameters" do
    expect_no_offenses(<<~RUBY)
      before(:each, :foo, bar: true) do
        # some code
      end
    RUBY
  end

  it "registers an offense when `before` is used with a block parameter" do
    expect_offense(<<~RUBY)
      before do |example|
      ^^^^^^^^^^^^^^^^^^^ Specify the parameter in `before` blocks. Example : before(:each) or before(:all)
        # some code
      end
    RUBY
  end
end
