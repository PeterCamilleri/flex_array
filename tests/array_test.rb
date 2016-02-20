require_relative '../lib/flex_array'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

class ArrayTester < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_the_limits_method
    test = [1,2,3,4,5,6]
    assert_equal([0...6], test.limits)
  end

  def test_the_array_specs_method
    test = [1,2,3,4,5,6].array_specs
    assert_equal(1, test.length)
    assert_equal(SpecComponent, test[0].class)
    assert_equal(0...6, test[0].range)
    assert_equal(1, test[0].stride)
  end

  def test_the_array_data_method
    test = [1,2,3,4,5,6]
    assert_equal(test, test.array_data)
    assert_equal(test.object_id, test.array_data.object_id)
  end

  def test_the_count_method
    test = [1,2,3,4,5,6]
    assert_equal(test.count, 6)
    assert_equal(test.count, test.length)
  end

  def test_the_to_index_range_method
    spec = SpecComponent.new(0...10, 1)

    assert_equal([0], [0].to_index_range(spec))
    assert_equal([9,9], [9,9].to_index_range(spec))
    assert_equal([0,9], [0,9].to_index_range(spec))

    assert_equal([0, 9], [0,-1].to_index_range(spec))
    assert_equal([1, 8], [1,-2].to_index_range(spec))
    assert_equal([8, 9], [-2,-1].to_index_range(spec))

    assert_raises(IndexError) { [0,10].to_index_range(spec) }

    assert_raises(TypeError) { [:one, :two].to_index_range(spec) }
  end
end
