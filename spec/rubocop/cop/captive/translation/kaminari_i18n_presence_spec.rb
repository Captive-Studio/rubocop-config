# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RuboCop::Cop::Captive::Translation::KaminariI18nPresence do
  subject(:cop) { described_class.new }

  context 'when `kaminari` is present in Gemfile but `kaminari-i18n` is not' do
    let(:source) { "gem 'kaminari', '~> 4.8.0'" }

    it 'registers an offense' do
      expect_offense(<<~RUBY)
        #{source}
        ^^^^^^^^^^^^^^^^^^^^^^^^^^ The gem `kaminari-i18n` should be added to the Gemfile if `kaminari` is present in Gemfile
      RUBY
    end
  end

  context 'when both `kaminari` and `kaminari-i18n` are present in Gemfile' do
    before { allow(Gem).to receive_message_chain(:loaded_specs, :keys, :include?).and_return(true) }

    let(:source) do
      <<~RUBY
        gem 'kaminari', '~> 4.8.0'
        gem 'kaminari-i18n', '~> 1.10.0'
      RUBY
    end

    it 'does not register an offense' do
      expect_no_offenses(source)
    end
  end

  context 'when `kaminari-i18n` is present in Gemfile but `kaminari` is not' do
    let(:source) { "gem 'kaminari-i18n', '~> 1.10.0'" }

    it 'does not register an offense' do
      expect_no_offenses(source)
    end
  end
end
