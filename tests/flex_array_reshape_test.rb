require_relative '../lib/flex_array'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

class FlexArrayReshapeTester < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_the_reshape_method
    ba1 = [[0,0], [0,1], [0,2], [0,3],
           [1,0], [1,1], [1,2], [1,3],
           [2,0], [2,1], [2,2], [2,3]]

    fa1 = FlexArray.new([3,4]) {|idx| idx.clone}
    fa2 = fa1.reshape([2,6])
    assert_equal([0...3, 0...4], fa1.limits)
    assert_equal([0...2, 0...6], fa2.limits)
    assert_equal(ba1, fa1.array_data)
    assert_equal(ba1, fa2.array_data)

    ba2 = [[0,0], [0,1], [0,2], [0,3],
           [1,0], [1,1], [1,2], [1,3],
           [2,0], [2,1], [2,2], [2,3],
           [0,0], [0,1], [0,2]]

    fa3 = fa1.reshape([3,5])
    assert_equal(ba2, fa3.array_data)
  end

  def test_the_reshape_e_m_method
    ba1 = [[0,0], [0,1], [0,2], [0,3],
           [1,0], [1,1], [1,2], [1,3],
           [2,0], [2,1], [2,2], [2,3]]

    fa1 = FlexArray.new([3,4]) {|idx| idx.clone}
    fa1.reshape!([2,6])
    assert_equal([0...2, 0...6], fa1.limits)
    assert_equal(ba1, fa1.array_data)
    assert_equal(2, fa1.dimensions)

    ba2 = [[0,0], [0,1], [0,2], [0,3],
           [1,0], [1,1], [1,2], [1,3],
           [2,0], [2,1], [2,2], [2,3],
           [0,0], [0,1], [0,2]]

    fa1.reshape!([3,5])
    assert_equal(ba2, fa1.array_data)
    assert_equal(2, fa1.dimensions)

    fa1.reshape!(15)
    assert_equal([0...15], fa1.limits)
    assert_equal(1, fa1.dimensions)
  end

  def test_the_to_a_method
    fa = FlexArray.new([2,3]) {|idx| idx.clone}
    a = [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2]]
    assert_equal(a, fa.to_a)
    assert(fa.array_data.object_id != fa.to_a.object_id)

    fb = fa.transpose(0,1)
    b = [[0,0],[1,0],[0,1],[1,1],[0,2],[1,2]]
    assert_equal(b, fb.to_a)
  end
end
