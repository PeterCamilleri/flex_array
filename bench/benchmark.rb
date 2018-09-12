#Benchmark studies of flex array.

require 'benchmark'
require_relative '../lib/flex_array'

puts "Ruby version      = #{RUBY_VERSION}"
puts "FlexArray version = #{FlexArray::VERSION}"
puts

enable_creating_tests   = false
enable_accessing_tests  = true

ct  = 1000

sz  = 10000
s2d = [100, 100]
s3d = [10, 10, 100]
s4d = [10, 10, 10, 10]
s5d = [5, 5, 4, 10, 10]

puts "Creating arrays:"
puts "=============================================================================="

if enable_creating_tests

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

else
  puts "Test disabled."
end

puts

puts "Accessing arrays:"
puts "=============================================================================="

if enable_accessing_tests
  array = Array.new(sz, 9)
  fa_1d = FlexArray.new(sz, 9)
  fa_2d = FlexArray.new(s2d, 9)
  fa_3d = FlexArray.new(s3d, 9)
  fa_4d = FlexArray.new(s4d, 9)
  fa_5d = FlexArray.new(s5d, 9)

  temp = 0

  Benchmark.bmbm do |x|

    x.report("Array each:") {
      ct.times { array.each { |item| temp += item } }
    }

    x.report("Flex 1d each:") {
      ct.times { fa_1d.each { |item| temp += item } }
    }

    x.report("Flex 2d each:") {
      ct.times { fa_2d.each { |item| temp += item } }
    }

    x.report("Flex 3d each:") {
      ct.times { fa_3d.each { |item| temp += item } }
    }

    x.report("Flex 4d each:") {
      ct.times { fa_4d.each { |item| temp += item } }
    }

    x.report("Flex 5d each:") {
      ct.times { fa_5d.each { |item| temp += item } }
    }

  end
else
  puts "Test disabled."
end

puts
