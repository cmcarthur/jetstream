require './lib/components/zone'

require 'minitest'
require 'minitest/autorun'

describe Jet::Component::Zone do

  describe "new" do
    it "should not throw exception on valid az" do
      component = Jet::Component::Zone.new({
        :az => "us-east-1a"
      })

      assert(component)
    end
    
    it "should validate presence of az" do
      assert_raises ArgumentError do
        Jet::Component::Zone.new()
      end
    end

    it "should throw on invalid zone" do
      assert_raises ArgumentError do
        Jet::Component::Zone.new({
          :az => "us-east-1f"
        })
      end
    end

    it "should populate cidr blocks" do
      component = Jet::Component::Zone.new({
        :az => "us-east-1a"
      })

      assert_match(/10\.0\.[0-9]+\.0\/24/, component.properties[:public_cidr_block])
      assert_match(/10\.0\.[0-9]+\.0\/24/, component.properties[:private_cidr_block])
    end
  end

  describe "render" do
    it "should render" do
      component = Jet::Component::Zone.new({
        :az => "us-east-1a"
      })

      component.render
    end
  end
end
