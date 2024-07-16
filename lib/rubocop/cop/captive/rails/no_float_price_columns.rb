# frozen_string_literal: true

module RuboCop
  module Cop
    module Captive
      module Rails
        class NoFloatPriceColumns < Base
          MSG = "Avoid using `float` type for price columns. \
            Use `decimal, precision: 10, scale: 2` instead."

          def_node_matcher :add_column_call?, <<~PATTERN
            (send nil? :add_column _ $(sym {:price :prix}) (sym :float) ...)
          PATTERN

          def on_send(node)
            add_column_call?(node) do |column|
              add_offense(column, message: MSG)
            end
          end
        end
      end
    end
  end
end
