# frozen_string_literal: true

module RuboCop
  module Cop
    module RSpec
      # Checks for nested example groups.
      #
      # This cop is configurable using the `Max` option
      # and supports `--auto-gen-config`.
      #
      # @example
      #   # bad
      #   context 'when using some feature' do
      #     let(:some)    { :various }
      #     let(:feature) { :setup   }
      #
      #     context 'when user is signed in' do  # flagged by rubocop
      #       let(:user) do
      #         UserCreate.call(user_attributes)
      #       end
      #
      #       let(:user_attributes) do
      #         {
      #           name: 'John',
      #           age:  22,
      #           role: role
      #         }
      #       end
      #
      #       context 'when user is an admin' do # flagged by rubocop
      #         let(:role) { 'admin' }
      #
      #         it 'blah blah'
      #         it 'yada yada'
      #       end
      #     end
      #   end
      #
      #   # better
      #   context 'using some feature as an admin' do
      #     let(:some)    { :various }
      #     let(:feature) { :setup   }
      #
      #     let(:user) do
      #       UserCreate.call(
      #         name: 'John',
      #         age:  22,
      #         role: 'admin'
      #       )
      #     end
      #
      #     it 'blah blah'
      #     it 'yada yada'
      #   end
      #
      # @example configuration
      #
      #   # .rubocop.yml
      #   # RSpec/NestedGroups:
      #   #   Max: 2
      #
      #   context 'when using some feature' do
      #     let(:some)    { :various }
      #     let(:feature) { :setup   }
      #
      #     context 'when user is signed in' do
      #       let(:user) do
      #         UserCreate.call(user_attributes)
      #       end
      #
      #       let(:user_attributes) do
      #         {
      #           name: 'John',
      #           age:  22,
      #           role: role
      #         }
      #       end
      #
      #       context 'when user is an admin' do # flagged by rubocop
      #         let(:role) { 'admin' }
      #
      #         it 'blah blah'
      #         it 'yada yada'
      #       end
      #     end
      #   end
      #
      class NestedGroups < Base
        include ConfigurableMax
        include TopLevelGroup

        MSG = 'Maximum example group nesting exceeded [%<total>d/%<max>d].'

        DEPRECATED_MAX_KEY = 'MaxNesting'

        DEPRECATION_WARNING =
          "Configuration key `#{DEPRECATED_MAX_KEY}` for #{cop_name} is " \
          'deprecated in favor of `Max`. Please use that instead.'

        def on_top_level_group(node)
          find_nested_example_groups(node) do |example_group, nesting|
            self.max = nesting
            add_offense(
              example_group.send_node,
              message: message(nesting)
            )
          end
        end

        private

        def find_nested_example_groups(node, nesting: 1, &block)
          example_group = example_group?(node)
          yield node, nesting if example_group && nesting > max_nesting

          next_nesting = example_group ? nesting + 1 : nesting

          node.each_child_node(:block, :begin) do |child|
            find_nested_example_groups(child, nesting: next_nesting, &block)
          end
        end

        def message(nesting)
          format(MSG, total: nesting, max: max_nesting)
        end

        def max_nesting
          @max_nesting ||= Integer(max_nesting_config)
        end

        def max_nesting_config
          if cop_config.key?(DEPRECATED_MAX_KEY)
            warn DEPRECATION_WARNING
            cop_config.fetch(DEPRECATED_MAX_KEY)
          else
            cop_config.fetch('Max', 3)
          end
        end
      end
    end
  end
end
