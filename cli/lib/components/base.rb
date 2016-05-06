require './lib/components/interface'
require 'erb'

module Jet
  module Component
    class Base < Interface
      def initialize(params = {})
        @properties = {}
      end

      def hash
        return "base"
      end

      def self.deserialize(object)
        return self.class.new(object.properties)
      end

      def render
        renderer = ERB.new File.read("./lib/components/templates/base.tf.erb")
        return renderer.result(binding)
      end
    end
  end
end
