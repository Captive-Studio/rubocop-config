module RuboCop
  module Cop
    module Captive
      module Rails
        # This cop checks for the use of `after_commit` in Rails models.
        # Using `after_commit` can lead to unexpected behaviors and is discouraged.
        # Instead, consider using a service object to handle the logic that would
        # otherwise be placed inside an `after_commit` callback.
        #
        # For more information, see the documentation:
        # https://captive.notion.site/Quota-expir-PDF-Monkey-25e707bff8eb8094ba48ecc564fe5bd7?source=copy_link
        #
        # @example
        #   # bad
        #   class MyModel < ApplicationRecord
        #     after_commit :some_method
        #   end
        #
        #   # good
        #   class MyModel < ApplicationRecord
        #     def save_something
        #       MyService.new(self).call
        #     end
        #   end
        #
        #   # better
        #   # Use a service object for handling post-persistence logic
        #   class MyService
        #     def initialize(model)
        #       @model = model
        #     end
        #
        #     def call
        #       # Perform the operations needed after commit
        #     end
        #   end
        class AfterCommitNotAllowed < Cop
          MSG = "Interdit l'utilisation de `after_commit` dans les modèles Rails. \
            Utilisez un service plutôt."

          def_node_matcher :after_commit?, <<~PATTERN
            (send nil? :after_commit ...)
          PATTERN

          def on_send(node)
            add_offense(node, message: MSG) if after_commit?(node)
          end
        end
      end
    end
  end
end
