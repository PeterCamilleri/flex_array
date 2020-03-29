require_relative '../lib/flex_array'
gem              'minitest'
require          'minitest/autorun'

class SpecComponentTester < Minitest::Test

  def setup
    @lc = SpecComponent.new(1..5, 10)
  end

  def test_the_range
    assert_equal(1..5, @lc.range)
  end

  def test_the_stride
    assert_equal(10, @lc.stride)
  end

  def test_the_equality_operator
    a = SpecComponent.new(1..5, 1)
    b = SpecComponent.new(1..6, 10)

    assert(@lc == a)
    refute(@lc == b)
    refute(a == b)

    #Make sure our == operator plays well with arrays.
    assert([@lc] == [a])
    refute([@lc] == [b])
    refute([a] == [b])
  end

  def test_the_threequal_operator
    refute(@lc === 0)
    assert(@lc === 1)
    assert(@lc === 5)
    refute(@lc === 6)
  end

  def test_out_min
    assert_equal(1, @lc.min)
  end

  def test_out_max
    assert_equal(5, @lc.max)
  end

  def test_out_span
    assert_equal(5, @lc.span)

    @lc = SpecComponent.new(0...0, 10)
    assert_equal(0, @lc.span)
  end

  def test_out_each
    i = (1..5).each
    @lc.each {|v| assert_equal(i.next, v)}
  end

  def test_out_index_step
    assert_equal(0, @lc.index_step(1))
    assert_equal(40, @lc.index_step(5))

    @lc = SpecComponent.new(0...0, 10)
    assert_raises(TypeError) { @lc.index_step(1) }
  end

  def test_the_enlarge_method
    assert_equal(5, @lc.span)
    @lc.enlarge(5)
    assert_equal(10, @lc.span)

    @lc = SpecComponent.new(0...0, 10)
    assert_equal(0, @lc.span)
    assert(@lc.range.none?)
    @lc.enlarge(5)
    assert_equal(0...5, @lc.range)
    assert_equal(5, @lc.span)
    refute(@lc.range.none?)
  end
end
