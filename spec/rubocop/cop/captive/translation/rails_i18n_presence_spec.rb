# frozen_string_literal: true

require "spec_helper"

RSpec.describe RuboCop::Cop::Captive::Translation::RailsI18nPresence do
  subject(:cop) { described_class.new }

  context "when `rails` is present in Gemfile but `rails-i18n` is not" do
    let(:source) { "gem 'rails', '~> 4.8.0'" }

    it "registers an offense" do
      expect_offense(<<~RUBY)
        #{source}
        ^^^^^^^^^^^^^^^^^^^^^^^ Captive/Translation/RailsI18nPresence: The gem `rails-i18n` should be added to the Gemfile if `rails` is present in Gemfile
      RUBY
    end
  end

  context "when both `rails` and `rails-i18n` are present in Gemfile" do
    before(:each) do
      allow(Gem).to receive_message_chain(:loaded_specs, :keys, :include?).and_return(true)
    end

    let(:source) do
      <<~RUBY
        gem 'rails', '~> 4.8.0'
        gem 'rails-i18n', '~> 1.10.0'
      RUBY
    end

    it "does not register an offense" do
      expect_no_offenses(source)
    end
  end

  context "when `rails-i18n` is present in Gemfile but `rails` is not" do
    let(:source) { "gem 'rails-i18n', '~> 1.10.0'" }

    it "does not register an offense" do
      expect_no_offenses(source)
    end
  end
end
