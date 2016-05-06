require './lib/renderer'

require 'minitest'
require 'minitest/autorun'

describe Jet::Renderer do
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
        :private_cidr_block => "10.0.1.0/24",
        :public_cidr_block => "10.0.2.0/24"
      },
      :ref => nil
    }
  end

  describe "render_all!" do
    it "should render base only" do
      repository = Jet::Component::Repository.new([@base])

      renderer = Jet::Renderer.new(repository)
      renderer.render_all!

      repository.state.each do |component|
        assert(component[:ref])
      end
    end

    it "should render base and zone" do
      repository = Jet::Component::Repository.new([@base, @zone])

      renderer = Jet::Renderer.new(repository)
      renderer.render_all!

      repository.state.each do |component|
        assert(component[:ref])
      end
    end

    it "should FAIL when rendering zone only" do
      repository = Jet::Component::Repository.new([@zone])

      renderer = Jet::Renderer.new(repository)

      assert_raises ArgumentError do
        renderer.render_all!
      end
    end
  end
end
