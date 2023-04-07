# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RuboCop::Cop::Captive::Translation::DeviseI18nPresence do
  subject(:cop) { described_class.new }

  context 'when `devise` is present in Gemfile but `devise-i18n` is not' do
    let(:source) { "gem 'devise', '~> 4.8.0'" }

    it 'registers an offense' do
      expect_offense(<<~RUBY)
        #{source}
        ^^^^^^^^^^^^^^^^^^^^^^^^ Captive/Translation/DeviseI18nPresence: The gem `devise-i18n` should be added to the Gemfile if `devise` is present in Gemfile
      RUBY
    end
  end

  context 'when both `devise` and `devise-i18n` are present in Gemfile' do
    before { allow(Gem).to receive_message_chain(:loaded_specs, :keys, :include?).and_return(true) }

    let(:source) do
      <<~RUBY
        gem 'devise', '~> 4.8.0'
        gem 'devise-i18n', '~> 1.10.0'
      RUBY
    end

    it 'does not register an offense' do
      expect_no_offenses(source)
    end
  end

  context 'when `devise-i18n` is present in Gemfile but `devise` is not' do
    let(:source) { "gem 'devise-i18n', '~> 1.10.0'" }

    it 'does not register an offense' do
      expect_no_offenses(source)
    end
  end
end
