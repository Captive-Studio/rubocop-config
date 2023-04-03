# frozen_string_literal: true

module RuboCop
  module Cop
    module Captive
      module Translation
        class DeviseI18nPresence < RuboCop::Cop::Cop
          MSG = 'If devise gem is present, devise-i18n gem should be added to the Gemfile.'

          def on_send(node)
            return unless node.command?(:gem)

            gem_name = node.arguments[0]&.value
            return unless gem_name == 'devise'

            add_offense(node, message: MSG) unless devise_i18n_present?
          end

          private

          def devise_i18n_present?
            Gem.loaded_specs.keys.include?('devise-i18n')
          end
        end
      end
    end
  end
end
