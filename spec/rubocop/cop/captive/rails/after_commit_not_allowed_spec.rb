# frozen_string_literal: true

require "spec_helper"

RSpec.describe RuboCop::Cop::Captive::Rails::AfterCommitNotAllowed do
  subject(:cop) { described_class.new }

  it 'registers an offense for after_commit' do
    expect_offense(<<~RUBY)
      class SomeModel < ApplicationRecord
        after_commit :some_method
        ^^^^^^^^^^^^^^^^^^^^^^^^^ Captive/Rails/AfterCommitNotAllowed: Interdit l'utilisation de `after_commit` dans les modèles Rails.
      end
    RUBY
  end

  it 'does not register an offense for other callbacks' do
    expect_no_offenses(<<~RUBY)
      class SomeModel < ApplicationRecord
        after_save :some_method
      end
    RUBY
  end
end
