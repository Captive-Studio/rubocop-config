# frozen_string_literal: true

require "spec_helper"

describe RuboCop::Cop::Captive::Rails::NoFindByInScope do
  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }

  it "registers an offense when using find_by inside a scope" do
    expect_offense(<<~RUBY)
      scope :by_odoo_id, -> (odoo_id) { find_by(odoo_id: odoo_id) }
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Avoid using `find_by` in a scope. Use `where` to return a collection or define a class method if you need a single record.
    RUBY
  end

  it "does not register an offense when using where inside a scope" do
    expect_no_offenses(<<~RUBY)
      scope :by_odoo_id, -> (odoo_id) { where(odoo_id: odoo_id) }
    RUBY
  end

  it "does not register an offense when using find_by in a class method" do
    expect_no_offenses(<<~RUBY)
      def self.by_odoo_id(odoo_id)
        find_by(odoo_id: odoo_id)
      end
    RUBY
  end
end
