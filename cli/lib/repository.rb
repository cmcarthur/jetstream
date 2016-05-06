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

      def dependencies_met?(component)
        return component[:dependencies].all? do |dependency|
          @state.any? do |component|
            component[:name] == dependency
          end
        end
      end

      def build!(component)
        klass = COMPONENT_TYPES[component[:type]]

        if not dependencies_met?(component)
          raise ArgumentError.new("One or more dependencies were not met for #{component}.")
        end

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
