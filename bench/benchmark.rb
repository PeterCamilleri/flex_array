#Benchmark studies of flex array.

require 'benchmark'
require_relative '../lib/flex_array'

puts "Ruby version      = #{RUBY_VERSION}"
puts "FlexArray version = #{FlexArray::VERSION}"
puts

sz = 10000
s2 = 100    # s2 * s2 == sz
s3 = 10     # s3 * s3 * 2s == sz
ct = 1000

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
    ct.times { FlexArray.new([s2,s2], "cat") }
  }

  x.report("Flex 3d obj:") {
    ct.times { FlexArray.new([s3,s3,s2], "cat") }
  }

  x.report("Flex 4d obj:") {
    ct.times { FlexArray.new([s3,s3,s3,s3], "cat") }
  }


  x.report("Array blk:") {
    ct.times { Array.new(sz) {"cat"} }
  }

  x.report("Flex 1d blk:") {
    ct.times { FlexArray.new(sz) {"cat"} }
  }

  x.report("Flex 2d blk:") {
    ct.times { FlexArray.new([s2,s2]) {"cat"} }
  }

  x.report("Flex 3d blk:") {
    ct.times { FlexArray.new([s3,s3,s2]) {"cat"} }
  }

  x.report("Flex 4d blk:") {
    ct.times { FlexArray.new([s3,s3,s3,s3]) {"cat"} }
  }

end

