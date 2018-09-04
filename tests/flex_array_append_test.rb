require_relative '../lib/flex_array'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

class FlexArrayAppendTester < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_append_onto_an_existing_array
    f = FlexArray.new([1,3], "Title")
    assert_equal(2, f.dimensions)
    assert_equal([0...1, 0...3], f.limits)

    f << [1,2,3]
    assert_equal(2, f.dimensions)
    assert_equal([0..1, 0...3], f.limits)
    a = ["Title","Title","Title",1,2,3]
    assert_equal(a, f.array_data)

    g = FlexArray.new_from_array([4,5,6])
    f << g
    assert_equal(2, f.dimensions)
    assert_equal([0..2, 0...3], f.limits)
    a << 4 << 5 << 6
    assert_equal(a, f.array_data)
  end

  def test_append_onto_an_empty_array
    f = FlexArray.new([0,3])
    assert_equal(2, f.dimensions)
    assert_equal([0...0, 0...3], f.limits)

    f << [1,2,3]
    assert_equal(2, f.dimensions)
    assert_equal([0...1, 0...3], f.limits)
    a = [1,2,3]
    assert_equal(a, f.array_data)

    f << [4,5,6]
    assert_equal(2, f.dimensions)
    assert_equal([0..1, 0...3], f.limits)
    a = [1,2,3,4,5,6]
    assert_equal(a, f.array_data)
  end

  def test_append_failures
    f = FlexArray.new([1,3], "Title")
    assert_raises(ArgumentError) { f << [3,4] }
    assert_raises(ArgumentError) { f << [1,2,3,4] }

    g = FlexArray.new([1,2], "Title")
    assert_raises(ArgumentError) { f << g }
  end

end
