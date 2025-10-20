# lib/rubocop/no_disable_ddl_transaction.rb
module RuboCop
  module Cop
    module Captive
      module Rails
        ##
        # Cette migration utilise `disable_ddl_transaction!`, ce qui peut rendre le comportement de la migration
        # difficile à prévoir et potentiellement dangereux. Voici pourquoi il est important de l'éviter :
        #
        # 1. **Transactions atomiques :** Les migrations sont généralement exécutées dans une transaction afin de garantir
        #    que toutes les modifications d'une migration réussissent ou échouent ensemble. Cela permet de maintenir la
        #    cohérence de la base de données.
        #
        # 2. **Erreurs de schéma :** En désactivant la transaction, une erreur survenant lors de l'application des modifications
        #    peut laisser la base de données dans un état intermédiaire, ce qui complique le débogage et le retour en arrière.
        #
        # 3. **Verrouillage des tables :** Les opérations DDL sans transaction peuvent provoquer un verrouillage prolongé de
        #    la base de données, impactant la performance et l'accessibilité des tables pour d'autres requêtes pendant
        #    l'exécution de la migration.
        #
        # 4. **Difficulté de maintenance :** L'absence de transactions peut rendre plus difficile la maintenance de l'application,
        #    car il devient plus compliqué de conserver un historique clair des modifications apportées au schéma.
        #
        # Pour toutes ces raisons, nous devons éviter d'utiliser `disable_ddl_transaction!` afin de garantir une gestion
        # sécurisée et fiable des migrations.
        #
        # @see https://captive-team.atlassian.net/browse/CAE-290?focusedCommentId=24501
        class NoDisableDdlTransaction < Base
          MSG = "Avoid using 'disable_ddl_transaction!' in migrations.".freeze

          def_node_matcher :disable_ddl_transaction?, <<~PATTERN
            (send nil? :disable_ddl_transaction!)
          PATTERN

          def on_send(node)
            return unless disable_ddl_transaction?(node)

            add_offense(node)
          end
        end
      end
    end
  end
end
