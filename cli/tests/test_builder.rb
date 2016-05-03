require "./lib/components/builder"
require "./lib/components/base"
require "./lib/components/redshift"
require "./lib/components/zone"
require "test/unit"

class TestBuilder < Test::Unit::TestCase

  def test_build_invalid
    component = Jet::Component::Zone.new({:az => "us-east-1f"})
    result = Jet::Component::Builder.build(component)
    assert_equal(false, result)
  end

  def test_build_valid
    component = Jet::Component::Zone.new({:az => "us-east-1a"})
    result = Jet::Component::Builder.build(component)
    assert_equal(2, result.count)
  end

  def test_build_invalid
    component = Jet::Component::Zone.new({:az => "us-east-1f"})
    result = Jet::Component::Builder.render(component)
    assert_equal(false, result)
  end

  def test_render_valid
    component = Jet::Component::Zone.new({:az => "us-east-1a"})
    result = Jet::Component::Builder.render(component)
    assert(result.is_a? String)
  end

  def test_caching
    zone = Jet::Component::Zone.new({:az => "us-east-1a"})
    redshift = Jet::Component::Redshift.new(
      {:name => "test_redshift",
       :zone => "us-east-1a",
       :publicly_accessible => true})
    assert(Jet::Component::Builder.get("zone__us-east-1a"))
    assert(Jet::Component::Builder.get("redshift__test_redshift"))
    assert_equal(true, redshift.valid?)
  end

end
