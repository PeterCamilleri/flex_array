#Benchmark studies of flex array.

require 'benchmark'
require_relative '../lib/flex_array'

puts "Ruby version      = #{RUBY_VERSION}"
puts "FlexArray version = #{FlexArray::VERSION}"
puts

enable_creating_tests   = false
enable_accessing_tests  = true

ct     = 1000

sz  = 10000
s2d = [100, 100]
s3d = [10, 10, 100]
s4d = [10, 10, 10, 10]
s5d = [5, 5, 4, 10, 10]

c1s = [1..9998]
c2s = [1..98, 1..98]
c3s = [1..8, 1..8, 1..98]
c4s = [1..8, 1..8, 1..8, 1..8]
c5s = [1..3, 1..3, 1..2, 1..8, 1..8]


cyc_ct = ct*sz


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
  array =     Array.new(sz,  1.0)
  fa_1d = FlexArray.new(sz,  1.0)
  fa_2d = FlexArray.new(s2d, 1.0)
  fa_3d = FlexArray.new(s3d, 1.0)
  fa_4d = FlexArray.new(s4d, 1.0)
  fa_5d = FlexArray.new(s5d, 1.0)

  temp = 0.0

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


    x.report("Array cycle:") {
      cyc = array.cycle
      cyc_ct.times { temp += cyc.next }
    }

    x.report("Flex 1d cycle:") {
      cyc = fa_1d.cycle
      cyc_ct.times { temp += cyc.next }
    }

    x.report("Flex 2d cycle:") {
      cyc = fa_2d.cycle
      cyc_ct.times { temp += cyc.next }
    }

    x.report("Flex 3d cycle:") {
      cyc = fa_3d.cycle
      cyc_ct.times { temp += cyc.next }
    }

    x.report("Flex 4d cycle:") {
      cyc = fa_4d.cycle
      cyc_ct.times { temp += cyc.next }
    }

    x.report("Flex 5d cycle:") {
      cyc = fa_5d.cycle
      cyc_ct.times { temp += cyc.next }
    }


    x.report("Flex 1d cysel:") {
      cyc = fa_1d.select_cycle(c1s)
      cyc_ct.times { temp += cyc.next }
    }

    x.report("Flex 2d cysel:") {
      cyc = fa_2d.select_cycle(c2s)
      cyc_ct.times { temp += cyc.next }
    }

    x.report("Flex 3d cysel:") {
      cyc = fa_3d.select_cycle(c3s)
      cyc_ct.times { temp += cyc.next }
    }

    x.report("Flex 4d cysel:") {
      cyc = fa_4d.select_cycle(c4s)
      cyc_ct.times { temp += cyc.next }
    }

    x.report("Flex 5d cysel:") {
      cyc = fa_5d.select_cycle(c5s)
      cyc_ct.times { temp += cyc.next }
    }

  end
else
  puts "Test disabled."
end

puts
