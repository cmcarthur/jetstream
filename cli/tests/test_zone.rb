require "./lib/components/zone.rb"
require "test/unit"
require "mocha/test_unit"

class TestZone < Test::Unit::TestCase

  def test_zone
    assert_equal(4, 2+2)
  end

  def test_zone_az_required
    component = Jet::Component::Zone.new()

    assert_equal(false, component.valid?)
  end

  def test_zone_valid_az
    component = Jet::Component::Zone.new(
      {
        :az => "us-east-1a"
      })

    assert_equal(true, component.valid?)
  end

  def test_zone_invalid_az
    component = Jet::Component::Zone.new(
      {
        :az => "us-east-1f"
      })

    assert_equal(false, component.valid?)
  end

  def test_build
    component = Jet::Component::Zone.new(
      {
        :az => "us-east-1a"
      })

    component.build
  end

end
