require './lib/components/base.rb'

require 'minitest'
require 'minitest/autorun'

describe Jet::Component::Base do

  describe "new" do
    it "should initialize without exceptions" do
      assert(Jet::Component::Base.new)
    end
  end

  describe "render" do
    it "should render without exceptions" do
      component = Jet::Component::Base.new
      component.render
    end
  end
end
