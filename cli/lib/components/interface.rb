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
          :type => @type,
          :dependencies => dependencies,
          :properties => @properties,
          :ref => nil
        }
      end
    end
  end
end
