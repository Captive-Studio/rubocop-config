# frozen_string_literal: true

module RuboCop
  module Cop
    module Captive
      module RSpec
        # This cop enforces specifying the parameter in RSpec `before` blocks.
        #
        # The cops was created because many people didn't know that `before`
        # method has default parameter value : `:each`
        #
        # @example
        #   # bad
        #   before do
        #     ...
        #   end
        #
        #   # good
        #   before(:each) do
        #     ...
        #   end
        #
        #   before(:all) do
        #     ...
        #   end
        #
        class SpecifyBeforeParameter < RuboCop::Cop::Base
          extend AutoCorrector

          MSG = "Specify the parameter in `before` blocks. Example : before(:each) or before(:all)"

          def_node_matcher :before_block?, <<~PATTERN
            (block
              (send nil? :before ...)
              ...
            )
          PATTERN

          def_node_search :before_without_parameter?, <<~PATTERN
            (send nil? :before)
          PATTERN

          def on_block(node)
            return unless before_block?(node)
            return unless before_without_parameter?(node)

            add_offense(node, message: MSG) do |corrector|
              corrector.replace(node.loc.expression, add_parameter(node))
            end
          end

          private

          def add_parameter(node)
            magic_number = 6
            source = node.loc.expression.source
            source.insert(source.index("before") + magic_number, "(:each)")
          end
        end
      end
    end
  end
end
