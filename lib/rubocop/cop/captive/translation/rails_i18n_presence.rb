# frozen_string_literal: true

require "rubocop"

module RuboCop
  module Cop
    module Captive
      module Translation
        # Ensure to use the gem rails-i18n in order to have translation
        #
        # @example
        #   # bad
        #   gem 'rails'
        #
        #   # good
        #   gem 'rails'
        #   gem 'rails-i18n'
        class RailsI18nPresence < RuboCop::Cop::Base
          MSG = "The gem `rails-i18n` should be added to the Gemfile "\
                "if `rails` is present in Gemfile"

          def on_send(node)
            return unless node.command?(:gem)

            gem_name = node.arguments[0]&.value
            return unless gem_name == "rails"

            add_offense(node, message: MSG) unless rails_i18n_present?
          end

          private

          def rails_i18n_present?
            Gem.loaded_specs.keys.include?("rails-i18n")
          end
        end
      end
    end
  end
end
