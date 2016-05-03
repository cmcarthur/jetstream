require 'erb'

module Jet
  module Component
    class Base

      def initialize(params = {})
      end

      def valid?
        return true
      end

      def dependencies
        return []
      end

      def hash
        return "base"
      end

      def build
        renderer = ERB.new File.read("./lib/components/templates/base.tf.erb")
        return renderer.result(binding)
      end
    end
  end
end
