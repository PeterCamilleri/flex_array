#* flex_array_forever.rb - Forever looping support for the flexible array class.
class FlexArray
  #A helper class that encapsulates the idea of looping without end!
  class ForEver
    #Do something until false == true ;-)
    def times(&block)
      loop {block.call}
    end

    #Convert an eternity into an integer. ;-)
    def to_i
      nil
    end
  end

  #Create a forever constant for use where infinite looping is needed.
  FOREVER = ForEver.new
end