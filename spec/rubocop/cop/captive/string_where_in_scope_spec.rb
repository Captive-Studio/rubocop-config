# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RuboCop::Cop::Captive::StringWhereInScope do
  subject(:cop) { described_class.new }

  it 'does not add offense for hash syntax' do
    expect_no_offenses('User.where(id: user_ids)')
  end

  it 'adds offense for string interpolation' do
    expect_offense(<<~RUBY)
      User.where('created_at > ?', 1.week.ago)
                 ^^^^^^^^^^^^^^^^ Captive/StringWhereInScope: The `where` method should be used in a scope in a model.
    RUBY
  end

  it 'adds offense for hardcoded string' do
    expect_offense(<<~RUBY)
      User.where("status IN ('active', 'inactive')")
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Captive/StringWhereInScope: The `where` method should be used in a scope in a model.
    RUBY
  end
end
