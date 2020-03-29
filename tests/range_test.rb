require_relative '../lib/flex_array'
gem              'minitest'
require          'minitest/autorun'

class RangeTester < Minitest::Test

  def test_that_to_spec_component_works
    lc = (0...10).to_spec_component(3)
    assert_equal(0...10, lc.range)
    assert_equal(3, lc.stride)

    lc = (0...0).to_spec_component(3)
    assert_equal(0...0, lc.range)
    assert_equal(3, lc.stride)
  end

  def test_that_to_spec_component_rejects_bad
    assert_raises(ArgumentError) { (8...0).to_spec_component(3) }
    assert_raises(ArgumentError) { ('a'..'b').to_spec_component(3) }
  end

  def test_the_to_index_range_method
    lc = SpecComponent.new(0...10, 1)
    assert_equal(1..2, (1...3).to_index_range(lc))
    assert_equal(8..9, (-2..-1).to_index_range(lc))
    assert_equal(2..8, (2..-2).to_index_range(lc))

    assert_raises(IndexError) { (1...11).to_index_range(lc) }
    assert_raises(IndexError) { (1..10).to_index_range(lc) }
    assert_raises(IndexError) { (-2..2).to_index_range(lc) }
  end
end