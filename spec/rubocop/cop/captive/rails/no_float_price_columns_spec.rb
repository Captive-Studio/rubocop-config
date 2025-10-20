# frozen_string_literal: true

require "spec_helper"

describe RuboCop::Cop::Captive::Rails::NoFloatPriceColumns do
  subject(:cop) { described_class.new }

  it 'registers an offense when adding a float column with name containing "price"' do
    expect_offense(<<~RUBY)
      add_column :products, :price, :float
                            ^^^^^^ Captive/Rails/NoFloatPriceColumns: Avoid using `float` type for price columns.             Use `decimal, precision: 10, scale: 2` instead.
    RUBY
  end

  it 'registers an offense when adding a float column with name containing "prix"' do
    expect_offense(<<~RUBY)
      add_column :products, :prix, :float
                            ^^^^^ Captive/Rails/NoFloatPriceColumns: Avoid using `float` type for price columns.             Use `decimal, precision: 10, scale: 2` instead.
    RUBY
  end

  it "does not register an offense when adding a float column with a different name" do
    expect_no_offenses(<<~RUBY)
      add_column :products, :weight, :float
    RUBY
  end

  it 'does not register an offense when adding a decimal column with name containing "price"' do
    expect_no_offenses(<<~RUBY)
      add_column :products, :price, :decimal, precision: 10, scale: 2
    RUBY
  end

  it 'does not register an offense when adding a decimal column with name containing "prix"' do
    expect_no_offenses(<<~RUBY)
      add_column :products, :prix, :decimal, precision: 10, scale: 2
    RUBY
  end
end
