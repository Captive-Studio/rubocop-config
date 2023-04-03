# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RuboCop::Cop::Captive::ActiveAdmin::ActiveAdminAddonsPresence do
  subject(:cop) { described_class.new }

  context 'when `activeadmin` is present in Gemfile but `activeadmin_addons` is not' do
    let(:source) { "gem 'activeadmin', '~> 4.8.0'" }

    it 'registers an offense' do
      expect_offense(<<~RUBY)
        #{source}
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The gem `activeadmin_addons` should be added to the Gemfile if `activeadmin` is present in Gemfile
      RUBY
    end
  end

  context 'when both `activeadmin` and `activeadmin_addons` are present in Gemfile' do
    before { allow(Gem).to receive_message_chain(:loaded_specs, :keys, :include?).and_return(true) }

    let(:source) do
      <<~RUBY
        gem 'activeadmin', '~> 4.8.0'
        gem 'activeadmin_addons', '~> 1.10.0'
      RUBY
    end

    it 'does not register an offense' do
      expect_no_offenses(source)
    end
  end

  context 'when `activeadmin_addons` is present in Gemfile but `activeadmin` is not' do
    let(:source) { "gem 'activeadmin_addons', '~> 1.10.0'" }

    it 'does not register an offense' do
      expect_no_offenses(source)
    end
  end
end
