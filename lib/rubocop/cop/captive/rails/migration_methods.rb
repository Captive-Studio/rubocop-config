# frozen_string_literal: true

module RuboCop
  module Cop
    module Captive
      module Rails
        ##
        # This cop ensures the use `change` method when is possible.
        #
        # Il est possible d'utiliser la méthode `change` lors de l'utilisation de méthode de ActiveRecord::Migration tel que : `remove_column`, `add_column`, `add_index`, ...
        # La méthode gère automatiquement le UP et le DOWN.
        # Il n'est donc pas nécéssaire définir le `def up` et `def down` seulement lors d'une migration de donnée
        #
        # @example
        #   # bad
        #   def up
        #     remove_column :table, :column, :type
        #   end
        #
        #   def down
        #     add_column :table, :column, :type
        #   end
        #
        #   # good
        #   def change
        #     remove_column :table, :column, :type
        #   end
        #
        # @see https://git.captive.fr/captive/iris-galerie/iris-platform/-/merge_requests/676#note_186669
        class MigrationMethods < Base
          MSG = "Avoid using ActiveRecord::Migration methods in `up` and `down` methods. \
            Use `change` instead."

          BLACKLISTED_METHODS = %i[
            add_column
            add_foreign_key
            add_index
            add_reference
            add_timestamps
            change_column
            change_table
            create_table
            create_join_table
            drop_table
            remove_column
            remove_foreign_key
            remove_index
            remove_reference
            remove_timestamps
            rename_column
            rename_index
            rename_table
          ].freeze

          def_node_search :migration_method?, <<~PATTERN
            (send nil? {#{BLACKLISTED_METHODS.map(&:inspect).join(" ")}} ...)
          PATTERN

          def on_def(node)
            return unless %i[up down].include?(node.method_name)
            return unless migration_method?(node)

            add_offense(node, message: MSG)
          end
        end
      end
    end
  end
end
