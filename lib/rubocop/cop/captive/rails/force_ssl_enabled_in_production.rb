# frozen_string_literal: true

module RuboCop
  module Cop
    module Captive
      module Rails
        ##
        # This cop ensures the config force_ssl is set to true.
        #
        # Pourquoi il faut configurer le `force_ssl` à `true` en production ?
        # 1) Ça redirige les requêtes http → https. C’est une option que permet également le routeur de Scalingo
        # 2) Ça ajoute un flag `Secure` sur les Cookies. S’il n’est pas présent, c’est considéré comme une vulnérabilité car ça peut permettre à un pirate de récupérer le cookie en HTTP et potentiellement voler la session.
        # @see https://www.notion.so/captive/Corriger-la-vuln-rabilit-Insecure-cookie-setting-missing-Secure-flag-7962ae24774d4de39dcda5a80cca4fcf?pvs=26&qid=
        # @see https://support.detectify.com/support/solutions/articles/48001048982-cookie-lack-secure-flag article détaillant la sécurité du cookie
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
