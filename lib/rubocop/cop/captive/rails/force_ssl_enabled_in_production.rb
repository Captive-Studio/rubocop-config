# frozen_string_literal: true

module RuboCop
  module Cop
    module Captive
      module Rails
        # This cop ensures the cofig force_ssl il set to true.
        class ForceSslEnabledInProduction < Base
          extend AutoCorrector

          MSG = "force_ssl should be enabled in production."

          def on_send(node)
            if setting_force_ssl_not_true?(node)
              add_offense(node, message: MSG) do |corrector|
                # Replace with 'true' only if the argument is not already 'true'
                unless node.arguments.first.true_type?
                  corrector.replace(
                    node.arguments.first.source_range,
                    "true"
                  )
                end
              end
            end
          end

          def on_new_investigation
            processed_source.comments.each do |comment|
              check_comment(comment)
            end
          end

          private

          def setting_force_ssl_not_true?(node)
            node.method_name == :force_ssl= && !node.arguments.first.true_type?
          end

          def check_comment(comment)
            return unless force_ssl_commented?(comment.text)

            add_offense(comment.loc.expression, message: MSG) do |corrector|
              corrector.replace(comment.loc.expression, "config.force_ssl = true")
            end
          end

          def force_ssl_commented?(comment_text)
            comment_text.match?(/^\s*#.*config\.force_ssl\s*=\s*true/)
          end
        end
      end
    end
  end
end
