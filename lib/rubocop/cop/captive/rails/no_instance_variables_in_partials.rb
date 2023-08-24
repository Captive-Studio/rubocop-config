# frozen_string_literal: true

module RuboCop
  module Cop
    module Captive
      module Rails
        # @example
        #   # _partial.html.erb
        #
        #   # BAD
        #   <div><%= @name %></div>
        #
        #   # GOOD
        #   <div><%= name %></div>
        class NoInstanceVariablesInPartials < RuboCop::Cop::Cop
          MSG = "Avoid using instance variables in partials."

          def on_ivar(node)
            add_offense(node, message: MSG)
          end
        end
      end
    end
  end
end
