# frozen_string_literal: true

module RuboCop
  module Cop
    module Captive
      module Rails
        # Interdit l'utilisation de `has_many_attached` (Active Storage) dans les modèles Rails.
        #
        # À chaque utilisation de `has_many_attached`, on finit par avoir besoin d'informations
        # supplémentaires sur les fichiers (image de couverture, position, ordre, etc.), ce qu'on
        # ne peut pas faire avec des blobs seuls. Par exemple, un produit avec `has_many_attached
        # :images` permet d'afficher la première image en couverture, mais si cette image s'avère
        # être une grille de tailles et qu'on veut en choisir une autre, c'est impossible : les
        # pièces jointes sont de simples blobs sans attributs métier.
        #
        # La solution recommandée est d'utiliser un modèle associé (ex. `Photo`) avec
        # `has_one_attached :file` et des attributs (position, type, etc.). Cela évite une
        # migration coûteuse plus tard pour faire passer des millions d'images de blobs à un
        # vrai modèle.
        #
        # @see https://discuss.rubyonrails.org/t/active-storage-in-production-lessons-learned-and-in-depth-look-at-how-it-works/83289#p-254385-bonus-1-if-someone-were-to-write-active-storage-the-good-parts-then-has_many_attached-would-not-be-in-it-31
        class NoHasManyAttached < Base
          MSG = "N'utilisez pas `has_many_attached`. Préférez un modèle associé avec " \
                "`has_one_attached` pour pouvoir ajouter des attributs " \
                "(position, image de couverture, etc.)."

          def_node_matcher :has_many_attached?, <<~PATTERN
            (send nil? :has_many_attached ...)
          PATTERN

          def on_send(node)
            return unless has_many_attached?(node)

            add_offense(node, message: MSG)
          end
        end
      end
    end
  end
end
