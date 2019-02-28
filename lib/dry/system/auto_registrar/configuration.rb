module Dry
  module System
    module AutoRegistrar
      # Default auto_registrar configuration
      #
      # This is currently configured by default for every System::Container.
      # Configuration allows to define custom initialization as well as exclusion
      # logic, for each component that is being registered by Dry::System
      # auto-registration.
      #
      # @api private
      class Configuration
        DEFAULT_INSTANCE = ->(component, loader) { loader.instance }.freeze
        FALSE_PROC = -> * { false }.freeze

        def self.setting(name)
          define_method(name) do |&block|
            ivar = "@#{name}"
            if block
              instance_variable_set(ivar, block)
            else
              instance_variable_get(ivar)
            end
          end
        end

        setting :exclude
        setting :instance

        attr_accessor :memoize

        # @api private
        def initialize
          @instance = DEFAULT_INSTANCE
          @exclude = FALSE_PROC
          @memoize = false
        end
      end
    end
  end
end
