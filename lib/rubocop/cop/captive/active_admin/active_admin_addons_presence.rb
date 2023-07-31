# frozen_string_literal: true

module RuboCop
  module Cop
    module Captive
      module ActiveAdmin
        # Ensure to use the gem activeadmin_addons in order to have some additionnal features
        #
        # @example
        #   # bad
        #   gem 'activeadmin'
        #
        #   # good
        #   gem 'activeadmin'
        #   gem 'activeadmin_addons'
        class ActiveAdminAddonsPresence < RuboCop::Cop::Cop
          MSG = "The gem `activeadmin_addons` should be added to the Gemfile "\
                "if `activeadmin` is present in Gemfile"

          def on_send(node)
            return unless node.command?(:gem)

            gem_name = node.arguments[0]&.value
            return unless gem_name == "activeadmin"

            add_offense(node, message: MSG) unless activeadmin_addons_present?
          end

          private

          def activeadmin_addons_present?
            Gem.loaded_specs.keys.include?("activeadmin_addons")
          end
        end
      end
    end
  end
end
