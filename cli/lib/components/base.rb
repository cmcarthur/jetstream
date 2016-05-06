require './lib/components/interface'
require 'erb'

module Jet
  module Component
    class Base < Interface
      def initialize(params = {})
        @properties = {}
        @type = "base"
      end

      def hash
        return "base"
      end

      def dependencies
        return []
      end

      def self.deserialize(object)
        return Base.new(object[:properties])
      end

      def render
        renderer = ERB.new File.read("./lib/components/templates/base.tf.erb")
        return renderer.result(binding)
      end
    end
  end
end
