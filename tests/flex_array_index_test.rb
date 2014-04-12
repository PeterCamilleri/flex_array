require_relative '../lib/flex_array'
require          'minitest/autorun'

class FlexArrayIndexTester < MiniTest::Unit::TestCase
  $do_this_only_one_time = "" unless defined? $do_this_only_one_time

  def initialize(*all)
    if $do_this_only_one_time != __FILE__
      puts
      puts "Running test file: #{File.split(__FILE__)[1]}"
      $do_this_only_one_time = __FILE__
    end

    super(*all)
  end

  def test_that_it_indexes_correctly
    q1 = FlexArray.new([3, 3, 3]) {|i| i.dup}

    (0...3).each do |x|
      (0...3).each do |y|
        (0...3).each do |z|
          assert_equal([x,y,z], q1[x,y,z])
        end
      end
    end

    (-3..-1).each do |x|
      (-3..-1).each do |y|
        (-3..-1).each do |z|
          assert_equal([x+3,y+3,z+3], q1[x,y,z])
        end
      end
    end

    q = q1[0, 0, :all]
    a = [[0,0,0], [0,0,1], [0,0,2]]
    assert_equal(a, q)
    q = q1[0, 0, 0...3]
    assert_equal(a, q)
    q = q1[0, 0, -3..-1]
    assert_equal(a, q)
    q = q1[0, 0, [0,2]]
    assert_equal(a, q)
    q = q1[0, 0, [0,-1]]
    assert_equal(a, q)
    q = q1[0, 0, [-3,-1]]
    assert_equal(a, q)
    q = q1[0, 0, [-3,2]]
    assert_equal(a, q)

    q = q1[0, :all, 0]
    a = [[0,0,0], [0,1,0], [0,2,0]]
    assert_equal(a, q)
    q = q1[0, 0...3, 0]
    assert_equal(a, q)
    q = q1[0, -3..-1, 0]
    assert_equal(a, q)
    q = q1[0, [0,2], 0]
    assert_equal(a, q)
    q = q1[0, [0,-1], 0]
    assert_equal(a, q)
    q = q1[0, [-3,-1], 0]
    assert_equal(a, q)
    q = q1[0, [-3,2], 0]
    assert_equal(a, q)

    q = q1[:all, 0, 0]
    a = [[0,0,0], [1,0,0], [2,0,0]]
    assert_equal(a, q)
    q = q1[0...3, 0, 0]
    assert_equal(a, q)
    q = q1[-3..-1, 0, 0]
    assert_equal(a, q)
    q = q1[[0,2], 0, 0]
    assert_equal(a, q)
    q = q1[[0,-1], 0, 0]
    assert_equal(a, q)
    q = q1[[-3,-1], 0, 0]
    assert_equal(a, q)
    q = q1[[-3,2], 0, 0]
    assert_equal(a, q)

    q = q1[0, 1, :all]
    a = [[0,1,0], [0,1,1], [0,1,2]]
    assert_equal(a, q)
    q = q1[0, 1, 0...3]
    assert_equal(a, q)
    q = q1[0, 1, -3..-1]
    assert_equal(a, q)
    q = q1[0, 1, [0,2]]
    assert_equal(a, q)
    q = q1[0, 1, [0,-1]]
    assert_equal(a, q)
    q = q1[0, 1, [-3,-1]]
    assert_equal(a, q)
    q = q1[0, 1, [-3,2]]
    assert_equal(a, q)

    q = q1[0, :all, 1]
    a = [[0,0,1], [0,1,1], [0,2,1]]
    assert_equal(a, q)
    q = q1[0, 0...3, 1]
    assert_equal(a, q)
    q = q1[0, -3..-1, 1]
    assert_equal(a, q)
    q = q1[0, [0,2], 1]
    assert_equal(a, q)
    q = q1[0, [0,-1], 1]
    assert_equal(a, q)
    q = q1[0, [-3,-1], 1]
    assert_equal(a, q)
    q = q1[0, [-3,2], 1]
    assert_equal(a, q)

    q = q1[:all, 1, 0]
    a = [[0,1,0], [1,1,0], [2,1,0]]
    assert_equal(a, q)
    q = q1[0...3, 1, 0]
    assert_equal(a, q)
    q = q1[-3..-1, 1, 0]
    assert_equal(a, q)
    q = q1[[0,2], 1, 0]
    assert_equal(a, q)
    q = q1[[0,-1], 1, 0]
    assert_equal(a, q)
    q = q1[[-3,-1], 1, 0]
    assert_equal(a, q)
    q = q1[[-3,2], 1, 0]
    assert_equal(a, q)

    q = q1[0, 2, :all]
    a = [[0,2,0], [0,2,1], [0,2,2]]
    assert_equal(a, q)
    q = q1[0, 2, 0...3]
    assert_equal(a, q)
    q = q1[0, 2, -3..-1]
    assert_equal(a, q)
    q = q1[0, 2, [0,2]]
    assert_equal(a, q)
    q = q1[0, 2, [0,-1]]
    assert_equal(a, q)
    q = q1[0, 2, [-3,-1]]
    assert_equal(a, q)
    q = q1[0, 2, [-3,2]]
    assert_equal(a, q)

    q = q1[0, :all, 2]
    a = [[0,0,2], [0,1,2], [0,2,2]]
    assert_equal(a, q)
    q = q1[0, 0...3, 2]
    assert_equal(a, q)
    q = q1[0, -3..-1, 2]
    assert_equal(a, q)
    q = q1[0, [0,2], 2]
    assert_equal(a, q)
    q = q1[0, [0,-1], 2]
    assert_equal(a, q)
    q = q1[0, [-3,-1], 2]
    assert_equal(a, q)
    q = q1[0, [-3,2], 2]
    assert_equal(a, q)

    q = q1[:all, 2, 0]
    a = [[0,2,0], [1,2,0], [2,2,0]]
    assert_equal(a, q)
    q = q1[0...3, 2, 0]
    assert_equal(a, q)
    q = q1[-3..-1, 2, 0]
    assert_equal(a, q)
    q = q1[[0,2], 2, 0]
    assert_equal(a, q)
    q = q1[[0,-1], 2, 0]
    assert_equal(a, q)
    q = q1[[-3,-1], 2, 0]
    assert_equal(a, q)
    q = q1[[-3,2], 2, 0]
    assert_equal(a, q)

    q = q1[0, :all, :all]
    a = [[0,0,0], [0,0,1], [0,0,2],
         [0,1,0], [0,1,1], [0,1,2],
         [0,2,0], [0,2,1], [0,2,2]]
    assert_equal(a, q)

    q = q1[0, 1..2, :all]
    a = [[0,1,0], [0,1,1], [0,1,2], [0,2,0], [0,2,1], [0,2,2]]
    assert_equal(a, q)

    q = q1[0, 0..2, :all]
    a = [[0,0,0], [0,0,1], [0,0,2],
         [0,1,0], [0,1,1], [0,1,2],
         [0,2,0], [0,2,1], [0,2,2]]
    assert_equal(a, q)

    q = q1[0, :all, 0..2]
    a = [[0,0,0], [0,0,1], [0,0,2],
           [0,1,0], [0,1,1], [0,1,2],
           [0,2,0], [0,2,1], [0,2,2]]
    assert_equal(a, q)

    q = q1[0, 0..2, 0..2]
    a = [[0,0,0], [0,0,1], [0,0,2],
           [0,1,0], [0,1,1], [0,1,2],
           [0,2,0], [0,2,1], [0,2,2]]
    assert_equal(a, q)

    assert_equal([2,2,2], q1[-1,-1,-1])
  end

  def test_that_it_rejects_bad_indexes
    q1 = FlexArray.new([3, 3, 3]) {|i| i.clone}

    assert_raises(IndexError) { q1[0,0,3] }
    assert_raises(IndexError) { q1[0,3,0] }
    assert_raises(IndexError) { q1[3,0,0] }

    assert_raises(IndexError) { q1[0,0,0..3] }
    assert_raises(IndexError) { q1[0,0..3,0] }
    assert_raises(IndexError) { q1[0..3,0,0] }
  end
end