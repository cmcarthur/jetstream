require "./lib/components/base.rb"
require "./lib/components/zone.rb"

module Jet
  module Component
    class Repository
      attr_reader :state

      COMPONENT_TYPES = {
        "base" => Jet::Component::Base,
        "zone" => Jet::Component::Zone
      }

      def build!(component)
        klass = COMPONENT_TYPES[component[:type]]
        component[:ref] = klass.new(component[:properties])
        return component
      end

      def build_all!
        @state.map! do |component|
          build!(component)
        end
      end

      def initialize(state = [])
        @state = state
      end
    end
  end
end
