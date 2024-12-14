# frozen_string_literal: true

module RuboCop
  module Cop
    module Captive
      module Translation
        # Ensure to use the gem devise-i18n in order to have translation
        #
        # @example
        #   # bad
        #   gem 'devise'
        #
        #   # good
        #   gem 'devise'
        #   gem 'devise-i18n'
        class DeviseI18nPresence < RuboCop::Cop::Base
          MSG = "The gem `devise-i18n` should be added to the Gemfile "\
                "if `devise` is present in Gemfile"

          def on_send(node)
            return unless node.command?(:gem)

            gem_name = node.arguments[0]&.value
            return unless gem_name == "devise"

            add_offense(node, message: MSG) unless devise_i18n_present?
          end

          private

          def devise_i18n_present?
            Gem.loaded_specs.keys.include?("devise-i18n")
          end
        end
      end
    end
  end
end
