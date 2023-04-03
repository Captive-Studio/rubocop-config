# frozen_string_literal: true

module RuboCop
  module Cop
    module Captive
      module Sidekiq
        class CronFormat < RuboCop::Cop::Cop
          MSG = "The `cron` value must be a string in the format `'0 0 * * *'`"

          def on_hash(node)
            node.each_pair do |key, value|
              next unless key.value == :cron

              if value.str_type? && value.value.count(' ') != 4
                add_offense(value, message: MSG)
              end
            end
          end
        end
      end
    end
  end
end
