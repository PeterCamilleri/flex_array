require_relative '../lib/flex_array'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

class FlexArrayEachTester < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

  def test_each
    d = [0,1,2,3,4,5,6,7,8]
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1]}
    it = d.each

    result = q.each do |v|
      assert_equal(it.next, v)
    end

    assert_equal(result, q)

    it = q.each

    result = d.each do |v|
      assert_equal(it.next, v)
    end
  end

  def test_select_each
    d = [0,1,2,3,4,5,6,7,8]
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1]}
    it = d.each

    result = q.select_each([:all]) do |v|
      assert_equal(it.next, v)
    end

    assert_equal(result, q)

    it = q.select_each([:all])
    d.each do |v|
      assert_equal(it.next, v)
    end

    it = d.each

    result = q.select_each([:all, :all]) do |v|
      assert_equal(it.next, v)
    end

    d = [0,1,2]
    it = d.each

    result = q.select_each([0, :all]) do |v|
      assert_equal(it.next, v)
    end

    d = [0,3,6]
    it = d.each

    result = q.select_each([:all, 0]) do |v|
      assert_equal(it.next, v)
    end
  end

  def test_each_with_index
    d1 = [0,1,2,3,4,5,6,7,8]
    d2 = [[0,0], [0,1], [0,2],
          [1,0], [1,1], [1,2],
          [2,0], [2,1], [2,2]]
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1]}
    i1 = d1.each
    i2 = d2.each

    q.each_with_index do |v, i|
      assert_equal(v, i1.next)
      assert_equal(i, i2.next)
    end

    iq = q.each_with_index
    i2 = d2.each

    d1.each do |v|
      a,b = iq.next
      assert_equal(a, v)
      assert_equal(b, i2.next)
    end
  end

  def test_select_each_with_index
    d1 = [0,1,2,3,4,5,6,7,8]
    d2 = [[0,0], [0,1], [0,2],
          [1,0], [1,1], [1,2],
          [2,0], [2,1], [2,2]]
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1]}
    i1 = d1.each
    i2 = d2.each

    q.select_each_with_index([:all]) do |v, i|
      assert_equal(v, i1.next)
      assert_equal(i, i2.next)
    end

    iq = q.select_each_with_index([:all])
    i2 = d2.each

    d1.each do |v|
      a,b = iq.next
      assert_equal(a, v)
      assert_equal(b, i2.next)
    end

    i1 = d1.each
    i2 = d2.each

    q.select_each_with_index([:all, :all]) do |v, i|
      assert_equal(v, i1.next)
      assert_equal(i, i2.next)
    end

    iq = q.select_each_with_index([:all, :all])
    i2 = d2.each

    d1.each do |v|
      a,b = iq.next
      assert_equal(a, v)
      assert_equal(b, i2.next)
    end

    d1 = [0,1,2]
    d2 = [[0,0], [0,1], [0,2]]

    i1 = d1.each
    i2 = d2.each

    q.select_each_with_index([0, :all]) do |v, i|
      assert_equal(v, i1.next)
      assert_equal(i, i2.next)
    end

    d1 = [0,3,6]
    d2 = [[0,0], [1,0], [2,0]]

    i1 = d1.each
    i2 = d2.each

    q.select_each_with_index([:all, 0]) do |v, i|
      assert_equal(v, i1.next)
      assert_equal(i, i2.next)
    end
  end

  def test_each_raw
    d0 = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    d1 = [100, 101, 102, 103, 104, 105, 106, 107, 108]
    d2 = [[0,0], [0,1], [0,2],
          [1,0], [1,1], [1,2],
          [2,0], [2,1], [2,2]]
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1] + 100}
    i0 = d0.each
    i1 = d1.each
    i2 = d2.each

    q._each_raw do |i, posn|
      assert_equal(posn, i0.next)
      assert_equal(q.array_data[posn], i1.next)
      assert_equal(i, i2.next)
    end

    iq = q._each_raw
    i1 = d1.each
    i2 = d2.each

    d0.each do |v|
      i, posn = iq.next
      assert_equal(posn, v)
      assert_equal(q.array_data[posn], i1.next)
      assert_equal(i, i2.next)
    end
  end

  def test_select_each_raw
    d0 = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    d1 = [100, 101, 102, 103, 104, 105, 106, 107, 108]
    d2 = [[0,0], [0,1], [0,2],
          [1,0], [1,1], [1,2],
          [2,0], [2,1], [2,2]]
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1] + 100}
    i0 = d0.each
    i1 = d1.each
    i2 = d2.each

    q._select_each_raw([:all]) do |i, posn|
      assert_equal(posn, i0.next)
      assert_equal(q.array_data[posn], i1.next)
      assert_equal(i, i2.next)
    end

    i0 = d0.each
    i1 = d1.each
    i2 = d2.each

    q._select_each_raw([:all, :all]) do |i, posn|
      assert_equal(posn, i0.next)
      assert_equal(q.array_data[posn], i1.next)
      assert_equal(i, i2.next)
    end

    d0 = [0, 1, 2]
    d1 = [100, 101, 102]
    d2 = [[0,0], [0,1], [0,2]]

    i0 = d0.each
    i1 = d1.each
    i2 = d2.each

    q._select_each_raw([0, :all]) do |i, posn|
      assert_equal(posn, i0.next)
      assert_equal(q.array_data[posn], i1.next)
      assert_equal(i, i2.next)
    end

    d0 = [0, 3, 6]
    d1 = [100, 103, 106]
    d2 = [[0,0], [1,0], [2,0]]

    i0 = d0.each
    i1 = d1.each
    i2 = d2.each

    q._select_each_raw([:all, 0]) do |i, posn|
      assert_equal(posn, i0.next)
      assert_equal(q.array_data[posn], i1.next)
      assert_equal(i, i2.next)
    end
  end

  def test_cycle
    d = [0,1,2,3,4,5,6,7,8,0,1,2]
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1]}
    i = 0

    q.cycle do |v|
      assert_equal(d[i], v)
      i += 1
      break if i == 12
    end

    iq = q.cycle

    d.each do |v|
      assert_equal(iq.next, v)
    end
  end

  def test_select_cycle
    d = [0,1,2,3,4,5,6,7,8,0,1,2]
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1]}
    i = 0

    q.select_cycle([:all]) do |v|
      assert_equal(d[i], v)
      i += 1
      break if i == 12
    end

    iq = q.select_cycle([:all])

    d.each do |v|
      assert_equal(iq.next, v)
    end

    i = 0

    q.select_cycle([:all, :all]) do |v|
      assert_equal(d[i], v)
      i += 1
      break if i == 12
    end

    iq = q.select_cycle([:all, :all])

    d.each do |v|
      assert_equal(iq.next, v)
    end

    d = [0,1,2,0,1,2,0,1,2,0,1,2]
    i = 0

    q.select_cycle([0, :all]) do |v|
      assert_equal(d[i], v)
      i += 1
      break if i == 12
    end

    iq = q.select_cycle([0, :all])

    d.each do |v|
      assert_equal(iq.next, v)
    end

    d = [0,3,6,0,3,6,0,3,6,0,3,6]
    i = 0

    q.select_cycle([:all, 0]) do |v|
      assert_equal(d[i], v)
      i += 1
      break if i == 12
    end

    iq = q.select_cycle([:all, 0])

    d.each do |v|
      assert_equal(iq.next, v)
    end
  end

  def test_flatten_collect
    d = [0,1,4,9,16,25,36,49,64]
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1]}

    b = q.flatten_collect {|v| v * v }
    assert_equal(d, b)
  end

  def test_select_flatten_collect
    d = [0,1,4,9,16,25,36,49,64]
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1]}

    b = q.select_flatten_collect([:all]) {|v| v * v }
    assert_equal(d, b)

    b = q.select_flatten_collect([:all, :all]) {|v| v * v }
    assert_equal(d, b)

    d = [0,1,4]
    b = q.select_flatten_collect([0, :all]) {|v| v * v }
    assert_equal(d, b)

    d = [0,9,36]
    b = q.select_flatten_collect([:all, 0]) {|v| v * v }
    assert_equal(d, b)
  end





  def test_collect
    d = [0,1,4,9,16,25,36,49,64]
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1]}
    a = q.collect {|v| v * v }
    assert_equal(d, a.array_data)
  end

  def test_select_collect
    d = [0,1,4,9,16,25,36,49,64]
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1]}
    a = q.select_collect([:all]) {|v| v * v }
    assert_equal(d, a.array_data)

    d = [0,1,16,81,256,625,1296,2401,4096]
    b = a.select_collect([:all, :all]) {|v| v * v }
    assert_equal(d, b.array_data)

    d = [0,1,256,81,256,625,1296,2401,4096]
    c = b.select_collect([0, :all]) {|v| v * v }
    assert_equal(d, c.array_data)

    d = [0,1,256,6561,256,625,1679616,2401,4096]
    e = c.select_collect([:all, 0]) {|v| v * v }
    assert_equal(d, e.array_data)
  end

  def test_collect_em
    d = [0,1,4,9,16,25,36,49,64]
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1]}
    q.collect! {|v| v * v }
    assert_equal(d, q.array_data)
  end

  def test_select_collect_em
    d = [0,1,4,9,16,25,36,49,64]
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1]}
    q.select_collect!([:all]) {|v| v * v }
    assert_equal(d, q.array_data)

    d = [0,1,16,81,256,625,1296,2401,4096]
    q.select_collect!([:all, :all]) {|v| v * v }
    assert_equal(d, q.array_data)

    d = [0,1,256,81,256,625,1296,2401,4096]
    q.select_collect!([0, :all]) {|v| v * v }
    assert_equal(d, q.array_data)

    d = [0,1,256,6561,256,625,1679616,2401,4096]
    q.select_collect!([:all, 0]) {|v| v * v }
    assert_equal(d, q.array_data)
  end

  def test_find_index
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1] + 100}
    i = q.find_index(107)
    assert_equal([2, 1], i)

    i = q.find_index { |v| v > 106 }
    assert_equal([2, 1], i)

    i = q.find_index(300)
    assert_nil(i)

    i = q.find_index { |v| v > 206 }
    assert_nil(i)
  end

  def test_select_find_index
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1] + 100}
    i = q.select_find_index([:all], 107)
    assert_equal([2, 1], i)

    i = q.select_find_index([:all, :all], 107)
    assert_equal([2, 1], i)

    i = q.select_find_index([0, :all], 107)
    assert_nil(i)

    i = q.select_find_index([1, :all], 107)
    assert_nil(i)

    i = q.select_find_index([2, :all], 107)
    assert_equal([2, 1], i)

    i = q.select_find_index([:all, 0], 107)
    assert_nil(i)

    i = q.select_find_index([:all, 1], 107)
    assert_equal([2, 1], i)

    i = q.select_find_index([:all, 2], 107)
    assert_nil(i)
  end

  def test_find_indexes
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1] + 100}
    i = q.find_indexes(107)
    assert_equal([[2, 1]], i)

    i = q.find_indexes { |v| v == 107 }
    assert_equal([[2, 1]], i)

    i = q.find_indexes { |v| v > 106 }
    assert_equal([[2, 1], [2, 2]], i)

    i = q.find_indexes(307)
    assert_equal([], i)

    i = q.find_indexes { |v| v > 406 }
    assert_equal([], i)
  end

  def test_select_find_indexes
    q = FlexArray.new([3, 3]) {|i| i[0] * 3 + i[1] + 100}
    i = q.select_find_indexes([:all], 107)
    assert_equal([[2, 1]], i)

    i = q.select_find_indexes([:all, :all], 107)
    assert_equal([[2, 1]], i)

    i = q.select_find_indexes([0, :all], 107)
    assert_equal([], i)

    i = q.select_find_indexes([1, :all], 107)
    assert_equal([], i)

    i = q.select_find_indexes([2, :all], 107)
    assert_equal([[2, 1]], i)

    i = q.select_find_indexes([:all, 0], 107)
    assert_equal([], i)

    i = q.select_find_indexes([:all, 1], 107)
    assert_equal([[2, 1]], i)

    i = q.select_find_indexes([:all, 2], 107)
    assert_equal([], i)
  end
end
