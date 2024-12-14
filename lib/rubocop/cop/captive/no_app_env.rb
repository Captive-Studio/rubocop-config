# frozen_string_literal: true

module RuboCop
  module Cop
    module Captive
      # This cop checks for usages of the `APP_ENV` environment variable.
      # Usage of `APP_ENV` is prohibited as it conflicts with standard Rails/Rack
      # environment variable `RAILS_ENV` and may lead to unexpected results.
      class NoAppEnv < RuboCop::Cop::Base
        MSG = "Do not use `APP_ENV` environment variable as it conflicts with "\
              "standard Rails/Rack environment variable `RAILS_ENV`."

        def_node_matcher :env_variable?, <<~PATTERN
          (send
            (const _ :ENV) {:[] :fetch}
            (str "APP_ENV")
            ...
          )
        PATTERN

        def on_send(node)
          return unless env_variable?(node)
          add_offense(node, message: MSG)
        end
      end
    end
  end
end
