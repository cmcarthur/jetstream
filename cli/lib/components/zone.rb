require 'erb'

module Jet
  module Component
    class Zone
      attr_reader :az

      VALID_ZONES = ["us-east-1a",
                     "us-east-1b",
                     "us-east-1c",
                     "us-east-1d",
                     "us-east-1e"]

      @@current_cidr_block = 0

      def initialize(params = {})
        @az = params[:az]
        @public_cidr_block = "10.0.1.0/24"
        @private_cidr_block = "10.0.2.0/24"
      end

      def valid?
        return VALID_ZONES.include? @az
      end

      def dependencies
        return [Jet::Component::Base]
      end

      def hash
        return "zone__#{@az}"
      end

      def build
        renderer = ERB.new File.read("./lib/components/templates/zone.tf.erb")
        return renderer.result(binding)
      end

      def get_next_cidr_block
        @@current_cidr_block += 1
        return "10.0.#{@@current_cidr_block}.0/24"
      end
    end
  end
end
