# frozen_string_literal: true

module RuboCop
  module Cop
    module Captive
      module Rails
        # This cop checks for email delivery methods in controllers.
        # Sending email in controllers is not allowed in order to follow the MVC standard
        # An email must be sent from a Model
        class NoEmailFromController < Base
          MSG = "Do not send emails from controllers. Because it doesn't follow the MVC standard"

          def_node_search :email_delivery?, <<~PATTERN
            (send _ {:deliver_now :deliver_later})
          PATTERN

          def on_send(node)
            return unless email_delivery?(node)

            controller_class = find_controller_class(node)
            return unless controller_class

            add_offense(node, message: MSG)
          end

          private

          def find_controller_class(node)
            node.ancestors.find do |ancestor|
              ancestor.is_a?(Parser::AST::Node) &&
                ancestor.type == :class &&
                ancestor.children[0].const_type?
            end
          end
        end
      end
    end
  end
end
