require_relative '../lib/flex_array'
require          'minitest/autorun'

class FlexArrayNewTester < MiniTest::Unit::TestCase
  $do_this_only_one_time = "" unless defined? $do_this_only_one_time

  def initialize(*all)
    if $do_this_only_one_time != __FILE__
      puts
      puts "Running test file: #{File.split(__FILE__)[1]}"
      $do_this_only_one_time = __FILE__
    end

    super(*all)
  end

  def test_the_new_method
    q1 = FlexArray.new(10, 0)
    a1 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    assert_equal(10, q1.count)
    assert_equal(1, q1.dimensions)
    assert_equal([0...10], q1.limits)
    assert_equal(a1, q1.array_data)

    q2 = FlexArray.new(1..10, 0)
    a2 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    assert_equal(10, q2.count)
    assert_equal(1, q2.dimensions)
    assert_equal([1..10], q2.limits)
    assert_equal(a2, q2.array_data)

    q3 = FlexArray.new(10) {|i| i[0]}
    a3 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert_equal(a3, q3.array_data)

    q4 = FlexArray.new(1..10) {|i| i[0]}
    a4 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    assert_equal(a4, q4.array_data)

    q5 = FlexArray.new([2, 2], 0)
    a5 = [0, 0, 0, 0]
    assert_equal(4, q5.count)
    assert_equal(2, q5.dimensions)
    assert_equal([0...2, 0...2], q5.limits)
    assert_equal(a5, q5.array_data)

    q6 = FlexArray.new([2, 2]) {|i| i.clone}
    a6 = [[0,0], [0,1], [1,0], [1,1]]
    assert_equal(a6, q6.array_data)
  end

  def test_the_dup_method
    fa1 = FlexArray.new(10) {|idx| idx.clone}
    fa2 = fa1.dup

    #Test that the array reference cells are independent.
    fa2[0] = 'Hello'
    assert_equal([0], fa1[0])
    assert_equal('Hello', fa2[0])

    #Test that the array contents are still dependant.
    fa2[1][0] = 'Dolly'
    assert_equal(['Dolly'], fa1[1])
    assert_equal(['Dolly'], fa2[1])
  end

  def test_the_new_from_method
    #Test new_from a regular array.
    ba1 = [1,2,3,4,5,6]
    q1 = FlexArray.new_from([2,3], ba1)
    assert_equal(ba1, q1.array_data)
    assert_equal(q1.limits, [0...2, 0...3])
    assert_equal(q1.dimensions, 2)

    #Test new_from with a smaller target.
    q2 = FlexArray.new_from(4, q1)
    a2 = [1,2,3,4]
    assert_equal(a2, q2.array_data)
    assert_equal(q2.dimensions, 1)

    #Test new_from with a larger target.
    q3 = FlexArray.new_from(8, q1)
    a3 = [1,2,3,4,5,6,1,2]
    assert_equal(a3, q3.array_data)
    assert_equal(q3.dimensions, 1)

    #Test new_from with same size but different shape.
    q4 = FlexArray.new_from([3,2], q1)
    assert_equal(ba1, q4.array_data)
    assert_equal(q4.limits, [0...3, 0...2])
    assert_equal(q4.dimensions, 2)
  end

  def test_the_new_from_selection_method
    #Create a new array from a row of data.
    fa1 = FlexArray.new([3,4]) {|idx| idx.clone}
    fa2 = FlexArray.new_from_selection(4, fa1, [0, :all])
    assert_equal([[0,0],[0,1],[0,2],[0,3]], fa2.array_data)

    #Create a new array from a column of data.
    fa1 = FlexArray.new([3,4]) {|idx| idx.clone}
    fa2 = FlexArray.new_from_selection(3, fa1, [:all, 0])
    assert_equal([[0,0],[1,0],[2,0]], fa2.array_data)
  end

  def test_the_new_from_array_method
    a = [0,1,2,3,4,5,6,7,8,9]
    f = FlexArray.new_from_array(a)
    assert_equal([0...10], f.limits)
    assert_equal(a.object_id, f.array_data.object_id)
  end

  def test_that_it_rejects_bad_specs
    assert_raises(ArgumentError) { FlexArray.new(10.5, 0) }
    assert_raises(ArgumentError) { FlexArray.new('Hello', 0) }
    assert_raises(ArgumentError) { FlexArray.new(:all, 0) }

    assert_raises(ArgumentError) { FlexArray.new([10.5], 0) }
    assert_raises(ArgumentError) { FlexArray.new(['Hello'], 0) }
    assert_raises(ArgumentError) { FlexArray.new([:all], 0) }

    assert_raises(ArgumentError) { FlexArray.new(1...1, 0) }
    assert_raises(ArgumentError) { FlexArray.new(-1..-5, 0) }

    assert_raises(ArgumentError) { FlexArray.new([1...1], 0) }
    assert_raises(ArgumentError) { FlexArray.new([-1..-5], 0) }

    assert_raises(ArgumentError) { FlexArray.new('a'..'z', 0) }
    assert_raises(ArgumentError) { FlexArray.new(['a'..'z'], 0) }
  end
end
