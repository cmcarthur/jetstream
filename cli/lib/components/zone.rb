require './lib/components/interface'
require 'erb'

module Jet
  module Component
    class Zone < Interface
      attr_reader :properties

      VALID_ZONES = ["us-east-1a",
                     "us-east-1b",
                     "us-east-1c",
                     "us-east-1d",
                     "us-east-1e"]

      @@next_available_cidr_block = 0

      def initialize(params = {})
        if not params[:az]
          raise ArgumentError.new("'az' is a required parameter.")
        end

        if not VALID_ZONES.include? params[:az]
          raise ArgumentError.new("#{params[:az]} isn't a valid availability zone.")
        end

        @properties = {
          :az => params[:az],
          :public_cidr_block => params[:public_cidr_block] || get_next_cidr_block,
          :private_cidr_block => params[:private_cidr_block] || get_next_cidr_block
        }
        @type = "zone"
      end

      def self.deserialize(object)
        return Zone.new(object[:properties])
      end

      def render
        renderer = ERB.new File.read("./lib/components/templates/zone.tf.erb")
        return renderer.result(binding)
      end

      def hash
        return "zone__#{@properties[:az]}"
      end

      def dependencies
        return [
          "base"
        ]
      end

      def get_next_cidr_block
        @@next_available_cidr_block += 1
        return "10.0.#{@@next_available_cidr_block}.0/24"
      end
    end
  end
end
