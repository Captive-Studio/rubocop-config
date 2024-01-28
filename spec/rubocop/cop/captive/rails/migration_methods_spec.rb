# frozen_string_literal: true

require "spec_helper"

describe RuboCop::Cop::Captive::Rails::MigrationMethods do
  subject(:cop) { described_class.new }

  it "registers an offense when using a blacklisted method in the `up` method" do
    expect_offense(<<~RUBY)
      def up
      ^^^^^^ Captive/Rails/MigrationMethods: Avoid using ActiveRecord::Migration methods in `up` and `down` methods. Use `change` instead.
        add_column :users, :name, :string
      end
    RUBY
  end

  it "registers an offense when using a blacklisted method in the `down` method" do
    expect_offense(<<~RUBY)
      def down
      ^^^^^^^^ Captive/Rails/MigrationMethods: Avoid using ActiveRecord::Migration methods in `up` and `down` methods. Use `change` instead.
        remove_column :users, :name
      end
    RUBY
  end

  it "does not register an offense when using a blacklisted method in the `change` method" do
    expect_no_offenses(<<~RUBY)
      def change
        add_column :users, :name, :string
      end
    RUBY
  end

  it "does not register an offense when using a blacklisted method outside of `up` and `down`" do
    expect_no_offenses(<<~RUBY)
      def some_method
        add_column :users, :name, :string
      end
    RUBY
  end
end
