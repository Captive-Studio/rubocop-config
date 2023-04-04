# frozen_string_literal: true

require 'rubocop'

module RuboCop
  module Cop
    module Captive
      module Translation
        class KaminariI18nPresence < RuboCop::Cop::Cop
          MSG = "The gem `kaminari-i18n` should be added to the Gemfile "\
                "if `kaminari` is present in Gemfile"

          def on_send(node)
            return unless node.command?(:gem)

            gem_name = node.arguments[0]&.value
            return unless gem_name == 'kaminari'

            add_offense(node, message: MSG) unless kaminari_i18n_present?
          end

          private

          def kaminari_i18n_present?
            Gem.loaded_specs.keys.include?('kaminari-i18n')
          end
        end
      end
    end
  end
end
