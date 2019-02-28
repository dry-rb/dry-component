module Dry
  module System
    class Config
      def self.new(&block)
        config = super
        yield(config) if block_given?
        config
      end

      def initialize
        @settings = {}
      end

      def to_hash
        @settings
      end

      private

      def method_missing(meth, value = nil)
        if meth.to_s.end_with?('=')
          @settings[meth.to_s.gsub('=', '').to_sym] = value
        elsif @settings.key?(meth)
          @settings[meth]
        else
          super
        end
      end
    end
  end
end
