# frozen_string_literal: true

module RuboCop
  module Cop
    module Captive
      module Rails
        # Avoid using `find_by` in a scope. Use `where` to return a collection or define a class method if you need a single record.
        class NoFindByInScope < RuboCop::Cop::Cop
          MSG = "Avoid using `find_by` in a scope. Use `where` to return \
            a collection or define a class method if you need a single record."

          def_node_matcher :find_by_in_scope?, <<~PATTERN
            (block
              (send nil? :scope ...)
              (args ...)
              (send nil? :find_by ...))
          PATTERN

          def on_block(node)
            find_by_in_scope?(node) do
              add_offense(node, message: MSG)
            end
          end
        end
      end
    end
  end
end
