require_relative '../lib/flex_array'
require          'minitest/autorun'

class FlexArrayTransposeTester < MiniTest::Unit::TestCase
  $do_this_only_one_time = "" unless defined? $do_this_only_one_time

  def initialize(*all)
    if $do_this_only_one_time != __FILE__
      puts
      puts "Running test file: #{File.split(__FILE__)[1]}"
      $do_this_only_one_time = __FILE__
    end

    super(*all)
  end

  def test_the_transpose_em_method
    f = FlexArray.new([3,3]) { |i| i[0]*3 + i[1] }
    a = [0,1,2,
         3,4,5,
         6,7,8]
    assert_equal(a, f[:all, :all])
    assert_equal(a, f[:all])

    f.transpose!(0,1)
    a = [0,3,6,
         1,4,7,
         2,5,8]
    assert_equal(a, f[:all, :all])
    assert_equal(a, f[:all])
  end

  def test_that_transpose_em_rejects_bad_args
    f = FlexArray.new([3,3]) { |i| i[0]*3 + i[1] }

    assert_raises(ArgumentError) { f.transpose!(0,2) }
    assert_raises(ArgumentError) { f.transpose!(-1,0) }
  end

  def test_the_transpose_method
    f = FlexArray.new([3,3]) { |i| i[0]*3 + i[1] }
    a = [0,1,2,
         3,4,5,
         6,7,8]
    assert_equal(a, f[:all, :all])
    assert_equal(a, f[:all])

    g = f.transpose(0,1)
    b = [0,3,6,
         1,4,7,
         2,5,8]

    assert_equal(a, f[:all, :all])
    assert_equal(a, f[:all])

    assert_equal(b, g[:all, :all])
    assert_equal(b, g[:all])
  end
end
