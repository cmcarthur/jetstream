require './lib/repository'

require 'minitest'
require 'minitest/autorun'

describe Jet::Repository do
  before :each do
    @base = {
      :name => "base",
      :type => "base",
      :dependencies => [],
      :properties => {},
      :ref => nil
    }

    @zone = {
      :name => "zone__us-east-1a",
      :type => "zone",
      :dependencies => [
        "base"
      ],
      :properties => {
        :az => "us-east-1a",
        :public_cidr_block => "10.0.1.0/24",
        :private_cidr_block => "10.0.2.0/24"
      },
      :ref => nil
    }
  end

  describe "Base" do
    it "should deserialize and serialize" do
      base_obj = Jet::Component::Base.deserialize @base
      base_repr = base_obj.serialize

      assert_equal(@base, base_repr)
    end
  end

  describe "Zone" do
    it "should deserialize and serialize" do
      zone_obj = Jet::Component::Zone.deserialize @zone
      zone_repr = zone_obj.serialize

      assert_equal(@zone, zone_repr)
    end
  end
end
