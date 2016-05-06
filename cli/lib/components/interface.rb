require 'digest/sha1'

module Jet
  module Component
    class Interface
      def hash
        name = self.class.name
        unique_id = Digest::SHA1.hexdigest @properties
        return "#{name}__#{unique_id}"
      end

      def serialize
        return {
          :name => hash,
          :dependencies => dependencies.map { |x| x.hash },
          :properties => @properties
        }
      end
    end
  end
end
