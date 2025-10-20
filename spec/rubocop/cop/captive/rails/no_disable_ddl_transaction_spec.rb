require "spec_helper"

describe RuboCop::Cop::Captive::Rails::NoDisableDdlTransaction do
  subject(:cop) { described_class.new }

  it "enregistre une infraction lors de l'utilisation de `disable_ddl_transaction!` dans une migration" do
    expect_offense(<<~RUBY)
      class SomeMigration < ActiveRecord::Migration[6.0]
        disable_ddl_transaction!
        ^^^^^^^^^^^^^^^^^^^^^^^^ Captive/Rails/NoDisableDdlTransaction: Avoid using 'disable_ddl_transaction!' in migrations.

        def change
          # Some migration code
        end
      end
    RUBY
  end

  it "n'enregistre pas d'infraction lorsque `disable_ddl_transaction!` n'est pas utilisé" do
    expect_no_offenses(<<~RUBY)
      class SomeMigration < ActiveRecord::Migration[6.0]
        def change
          add_column :users, :name, :string
        end
      end
    RUBY
  end
end
