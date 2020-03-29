require_relative '../lib/flex_array'
gem              'minitest'
require          'minitest/autorun'

class FlexArrayTester < Minitest::Test

  def test_version_reporting
    f = FlexArray.new([3,3], 'test')

    assert_equal(FlexArray::VERSION, FlexArray.version)
    assert_equal(FlexArray::VERSION, f.version)
  end

  def test_the_limits_method
    f = FlexArray.new([3,3], 'test')
    assert_equal([0...3, 0...3], f.limits)
  end

  def test_the_to_flex_array_method
    f = FlexArray.new([3,3], 'test')
    g = f.to_flex_array

    assert_equal(f, g)
    assert_equal(f.object_id, g.object_id)
  end

  def test_the_equal_method
    f = FlexArray.new([3,3], 'test')
    g = FlexArray.new([3,3], 'test')
    h = FlexArray.new([3,3], 'not')

    assert(f == g)
    refute(f == h)
  end

  def test_the_compariositality_method
    f = FlexArray.new([3,3], 1)
    g = FlexArray.new([3,3], 1)
    h = FlexArray.new([3,3], 2)
    i = FlexArray.new([3,3], 0)

    assert_equal( 0, f <=> g)
    assert_equal(-1, f <=> h)
    assert_equal( 1, f <=> i)
  end

  def test_the_empty_method
    f = FlexArray.new([3,3], 1)
    refute(f.empty?)

    g = FlexArray.new([0,3], 1)
    assert(g.empty?)
  end

end
