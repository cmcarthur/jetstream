require "./lib/main.rb"
require "test/unit"

class TestMain < Test::Unit::TestCase

  def test_sample
    assert_equal(4, 2+2)
  end

end
