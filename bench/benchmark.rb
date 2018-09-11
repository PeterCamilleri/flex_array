#Benchmark studies of flex array.

require 'benchmark'
require_relative '../lib/flex_array'

puts "Ruby version      = #{RUBY_VERSION}"
puts "FlexArray version = #{FlexArray::VERSION}"
puts

sz = 10000
s2 = 100    # s2 * s2 == sz
ct = 1000

Benchmark.bmbm do |x|

  x.report("Array obj:") {
    ct.times { Array.new(sz, "cat") }
  }

  x.report("Array blk:") {
    ct.times { Array.new(sz) {"cat"} }
  }

  x.report("Flex obj:") {
    ct.times { FlexArray.new(sz, "cat") }
  }

  x.report("Flex blk:") {
    ct.times { FlexArray.new(sz) {"cat"} }
  }

  x.report("Flex2 obj:") {
    ct.times { FlexArray.new([s2,s2], "cat") }
  }

  x.report("Flex2 blk:") {
    ct.times { FlexArray.new([s2,s2]) {"cat"} }
  }

end

