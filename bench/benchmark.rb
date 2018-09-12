#Benchmark studies of flex array.

require 'benchmark'
require_relative '../lib/flex_array'

puts "Ruby version      = #{RUBY_VERSION}"
puts "FlexArray version = #{FlexArray::VERSION}"
puts

ct  = 1000

sz  = 10000
s2d = [100, 100]
s3d = [10, 10, 100]
s4d = [10, 10, 10, 10]
s5d = [5, 5, 4, 10, 10]

puts "Creating arrays:"
puts "=============================================================================="

Benchmark.bmbm do |x|

  x.report("Array obj:") {
    ct.times { Array.new(sz, "cat") }
  }

  x.report("Flex 1d obj:") {
    ct.times { FlexArray.new(sz, "cat") }
  }

  x.report("Flex 2d obj:") {
    ct.times { FlexArray.new(s2d, "cat") }
  }

  x.report("Flex 3d obj:") {
    ct.times { FlexArray.new(s3d, "cat") }
  }

  x.report("Flex 4d obj:") {
    ct.times { FlexArray.new(s4d, "cat") }
  }

  x.report("Flex 5d obj:") {
    ct.times { FlexArray.new(s5d, "cat") }
  }


  x.report("Array blk:") {
    ct.times { Array.new(sz) {"cat"} }
  }

  x.report("Flex 1d blk:") {
    ct.times { FlexArray.new(sz) {"cat"} }
  }

  x.report("Flex 2d blk:") {
    ct.times { FlexArray.new(s2d) {"cat"} }
  }

  x.report("Flex 3d blk:") {
    ct.times { FlexArray.new(s3d) {"cat"} }
  }

  x.report("Flex 4d blk:") {
    ct.times { FlexArray.new(s4d) {"cat"} }
  }

  x.report("Flex 5d blk:") {
    ct.times { FlexArray.new(s5d) {"cat"} }
  }


  src = Array.new(sz, "cat")

  x.report("Flex 1d from:") {
    ct.times { FlexArray.new_from(sz, src) }
  }

  x.report("Flex 2d from:") {
    ct.times { FlexArray.new_from(s2d, src) }
  }

  x.report("Flex 3d from:") {
    ct.times { FlexArray.new_from(s3d, src) }
  }

  x.report("Flex 4d from:") {
    ct.times { FlexArray.new_from(s4d, src) }
  }

  x.report("Flex 5d from:") {
    ct.times { FlexArray.new_from(s5d, src) }
  }
end

