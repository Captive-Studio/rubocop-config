# frozen_string_literal: true

require "spec_helper"

RSpec.describe RuboCop::Cop::Captive::Rails::NoHasManyAttached do
  subject(:cop) { described_class.new }

  it "registers an offense for has_many_attached" do
    expect_offense(<<~RUBY)
      class Product < ApplicationRecord
        has_many_attached :images
        ^^^^^^^^^^^^^^^^^^^^^^^^^ Captive/Rails/NoHasManyAttached: N'utilisez pas `has_many_attached`. Préférez un modèle associé avec `has_one_attached` pour pouvoir ajouter des attributs (position, image de couverture, etc.).
      end
    RUBY
  end

  it "registers an offense for has_many_attached with options" do
    expect_offense(<<~RUBY)
      class Document < ApplicationRecord
        has_many_attached :files, dependent: :purge_later
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Captive/Rails/NoHasManyAttached: N'utilisez pas `has_many_attached`. Préférez un modèle associé avec `has_one_attached` pour pouvoir ajouter des attributs (position, image de couverture, etc.).
      end
    RUBY
  end

  it "does not register an offense for has_one_attached" do
    expect_no_offenses(<<~RUBY)
      class Company < ApplicationRecord
        has_one_attached :logo
      end
    RUBY
  end
end
