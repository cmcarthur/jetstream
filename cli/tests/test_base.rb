require "./lib/components/base.rb"
require "test/unit"

class TestBase < Test::Unit::TestCase

  def test_base
    component = Jet::Component::Base.new
    assert_equal(true, component.valid?)
  end

  def test_build
    component = Jet::Component::Base.new
    component.build
  end

end
