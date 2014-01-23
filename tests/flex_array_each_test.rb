require_relative '../lib/flex_array'
require          'minitest/autorun'

class FlexArrayEachTester < MiniTest::Unit::TestCase
  $do_this_only_one_time = "" unless defined? $do_this_only_one_time
  
  def initialize(*all)
    if $do_this_only_one_time != __FILE__
      puts
      puts "Running test file: #{File.split(__FILE__)[1]}" 
      $do_this_only_one_time = __FILE__
    end
    
    super(*all)
  end

  def test_that_the_each_verbs_work
    idx = []
    q = FlexArray.new([3, 3]) {|i| idx << i.clone; i[0]*i[1]}
    it = q.array_data.each
    
    q.each do |v|
      assert_equal(it.next, v)
    end
    
    it = q.each
    q.array_data.each do |v|
      assert_equal(it.next, v)
    end

    it = q.array_data.each
    it2 = idx.each
    q.each_with_index do |v, i|
      assert_equal(it.next, v)
      assert_equal(it2.next, i)
    end
    
    it = q.each_with_index
    it2 = idx.each
    q.array_data.each do |v|
      value, index = it.next
      assert_equal(value, v)
      assert_equal(it2.next, index)
    end
    
    it = (0...9).each
    it2 = idx.each
    q._each_raw do |d, index, p|
      assert_equal(d.object_id, q.array_data.object_id)
      assert_equal(it2.next, index)
      assert_equal(it.next, p)
    end
    
    it = q._each_raw
    it2 = idx.each
    (0...9).each do |i|
      d, index, p = it.next
      assert_equal(d.object_id, q.array_data.object_id)
      assert_equal(it2.next, index)
      assert_equal(i, p)
    end
  end

  def test_that_the_indexed_each_verbs_work
    q = FlexArray.new([3, 3]) {|i| i[0]*i[1]}
    a = [0, 1, 2]
    b = [[1,0], [1,1], [1,2]]
    it = a.each
    
    q.each([1, :all]) do |v|
      assert_equal(it.next, v)
    end
    
    it = q.each([1, :all])
    a.each do |v|
      assert_equal(it.next, v)
    end
    
    it = a.each
    it2 = b.each
    q.each_with_index([1, :all]) do |v, i|
      assert_equal(it.next, v)
      assert_equal(it2.next, i)
    end

    it = q.each_with_index([1, :all])
    it2 = b.each
    a.each do |v|
      value, index = it.next
      assert_equal(value, v)
      assert_equal(it2.next, index)
    end
    
    c = [3, 4, 5]
    it = c.each
    it2 = b.each
    q._each_raw([1, :all]) do |d, index, p|
      assert_equal(d.object_id, q.array_data.object_id)
      assert_equal(it2.next, index)
      assert_equal(it.next, p)
    end
    
    it = q._each_raw([1, :all])
    it2 = b.each
    c.each do |i|
      d, index, p = it.next
      assert_equal(d.object_id, q.array_data.object_id)
      assert_equal(it2.next, index)
      assert_equal(i, p)
    end
  end
  
  def test_that_flex_array_cycle_works
    a = FlexArray.new_from(3, [1,2,3])
    r = []
    it = a.cycle
    10.times {r << it.next}
    assert_equal([1,2,3,1,2,3,1,2,3,1], r)    
  end
end
