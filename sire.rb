# Really simple program # 3
# A Simple Interactive Ruby Environment
# SIRE Version 0.2.6

require 'readline'
require 'pp'
require_relative 'lib/flex_array'
include Readline

class Object 
  def classes
    begin
      klass = self
      
      begin
        klass = klass.class unless klass.instance_of?(Class)
        print klass
        klass = klass.superclass
        print " < " if klass
      end while klass
      
      puts
    end
  end
end

def q
  @done = true
  puts
  "Bye bye for now!"
end

def eval_puts(str)
  puts str
  eval str
end
 
puts "Welcome to SIRE for FlexArray"
puts "Simple Interactive Ruby Environment"
puts
puts "Use command 'q' to quit."
puts
@done = false

eval_puts "@a = FlexArray.new([2,3,4]) {|i| i.clone}"
eval_puts "@b = FlexArray.new([2,3,4]) {|i| (i[0]+i[2])*(i[1] + i[2])}"
eval_puts "@c = FlexArray.new([0,3])"
eval_puts "@d = FlexArray.new([3,3]) {|i| i[0]*3 + i[1]}"
puts

until @done
  begin
    line = readline('SIRE>', true)
    result = eval line
    pp result unless result.nil?
  rescue Interrupt
    @done = true
    puts
    puts
    pp "I'm done here!"
  rescue Exception => e
    puts
    puts "#{e.class} detected: #{e}"
    puts e.backtrace
    puts
  end
end

puts 
