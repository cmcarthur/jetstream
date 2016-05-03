require 'erb'

module Jet
  module Component
    class Redshift
      attr_reader :name
      attr_reader :zone
      attr_reader :publicly_accessible

      def initialize(params = {})
        @name = params[:name]
        @publicly_accessible = params[:publicly_accessible]
        @zone = Jet::Component::Builder.get(params[:zone])
      end

      def valid?
        return (
          @name and
          [true, false].include? @publicly_accessible and
          @zone)
      end

      def dependencies
        return [Jet::Component::Base]
      end

      def hash
        return "redshift__#{@name}"
      end

      def build
        renderer = ERB.new File.read("./lib/components/templates/zone.tf.erb")
        return renderer.result(binding)
      end
    end
  end
end
