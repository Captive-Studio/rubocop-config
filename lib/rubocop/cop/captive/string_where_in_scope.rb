# frozen_string_literal: true

module RuboCop
  module Cop
    module Captive
      class StringWhereInScope < RuboCop::Cop::Cop
        MSG = 'The `where` method should be used in a scope in a model.'

        def_node_matcher :where_with_string?, <<~PATTERN
          (send _ :where (str _) ...)
        PATTERN

        def on_send(node)
          return unless where_with_string?(node)

          options_node = node.arguments[0]
          return if options_node&.hash_type?

          add_offense(options_node, message: MSG)
        end
      end
    end
  end
end
