# coding: utf-8
# An IRB + flex array Test bed

require 'irb'

puts "Starting an IRB console with flex array loaded."

if ARGV[0] == 'local'
  require_relative 'lib/flex_array'
  puts "flex_array loaded locally: #{FlexArray::VERSION}"

  ARGV.shift
else
  require 'flex_array'
  puts "flex_array loaded from gem: #{FlexArray::VERSION}"
end

IRB.start
