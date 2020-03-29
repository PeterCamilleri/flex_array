require_relative '../lib/flex_array'
gem              'minitest'
require          'minitest/autorun'

class ObjectTester < Minitest::Test

  def test_that_to_spec_component_fails
    obj = Object.new
    assert_raises(ArgumentError) { obj.to_spec_component(42) }

    #Test other invalid objects as well...
    assert_raises(ArgumentError) { (89.0).to_spec_component(42) }
    assert_raises(ArgumentError) { 'Hello'.to_spec_component(42) }
    assert_raises(ArgumentError) { :Hello.to_spec_component(42) }
    assert_raises(ArgumentError) { [1,2,3].to_spec_component(42) }
    assert_raises(ArgumentError) { {:hi => 42}.to_spec_component(42) }
  end

  def test_the_to_index_range_method
    lc = SpecComponent.new(0...10, 1)
    assert_equal(0...10, (:all).to_index_range(lc))
    assert_raises(IndexError) { (:y_all).to_index_range(lc) }
    assert_raises(IndexError) { (:all_y_all).to_index_range(lc) }
    assert_raises(IndexError) { ('all').to_index_range(lc) }
    assert_raises(IndexError) { (98.9).to_index_range(lc) }
  end

end