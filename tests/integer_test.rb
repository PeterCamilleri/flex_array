require_relative '../lib/flex_array'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

class IntegerTester < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_that_to_spec_component_works
    lc = (10).to_spec_component(3)
    assert_equal(0...10, lc.range)
    assert_equal(3, lc.stride)

    lc = (0).to_spec_component(3)
    assert_equal(0...0, lc.range)
  end

  def test_that_to_spec_component_rejects_bad
    assert_raises(ArgumentError) { (-100).to_spec_component(3) }
  end

  def test_the_to_index_range_method
    lc = SpecComponent.new(0...10, 1)
    assert_equal(0..0, (0).to_index_range(lc))
    assert_equal(1..1, (1).to_index_range(lc))
    assert_equal(9..9, (-1).to_index_range(lc))

    assert_raises(IndexError) { (10).to_index_range(lc) }
    assert_raises(IndexError) { (-12).to_index_range(lc) }
  end

end