require_relative '../lib/flex_array'
require          'minitest/autorun'

class FlexArrayValidateTester < MiniTest::Unit::TestCase
  $do_this_only_one_time = "" unless defined? $do_this_only_one_time
  
  def initialize(*all)
    if $do_this_only_one_time != __FILE__
      puts
      puts "Running test file: #{File.split(__FILE__)[1]}" 
      $do_this_only_one_time = __FILE__
    end
    
    super(*all)
  end

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
  end
end
