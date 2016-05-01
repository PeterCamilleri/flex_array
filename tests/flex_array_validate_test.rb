require_relative '../lib/flex_array'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

class FlexArrayValidateTester < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_the_compatible_method
    f = FlexArray.new([3,3], 'f')
    g = FlexArray.new([0...3,0...3], 'g')
    h = FlexArray.new([1..3,1..3], 'h')
    i = FlexArray.new([3,3,3], 'i')
    j = FlexArray.new([3], 'j')

    assert(f.compatible?(g))
    refute(f.compatible?(h))
    refute(f.compatible?(i))
    refute(f.compatible?(j))

    assert(j.compatible?([1,2,3]))
    refute(j.compatible?([1,2,3,4]))

    refute(f.compatible?(42))
  end
end
