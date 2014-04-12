#* flex_array_new.rb - The flexible array class constructor and related methods.
class FlexArray
  #Construct a flexible array object.
  #<br>Parameters
  #* array_specs - The specification of the flex array subscript limits.
  #  These can either be integers, in which case the limits are 0...n or
  #  they can be ranges of integers, in which case the limits are those
  #  of the range, or they can be an array of integers and/or ranges of
  #  integers to represent arrays of more than one dimension.
  #* default - The optional default value. Defaults to nil.
  #* init_block - An optional initialization block. The return values from this
  #  block are used to initialize the array. This overrides the default value.
  #<br>Block Arguments
  #* index - An array with one element per dimension with the fully qualified
  #  index of the element being accessed. Note that the same array is passed
  #  in each time the block is called, so, if this parameter is to stored
  #  anywhere, it's best that it be cloned or duplicated first.
  def initialize(array_specs, default=nil, &init_block)
    @array_specs = SpecArray.new(array_specs.in_array)
    @transposed = false

    #Allocate the data for the array.
    @array_data = Array.new(@array_specs.spec_count, default)

    #Set up the array with the optional init_block.
    if init_block
      process_all {|index, posn| @array_data[posn] = init_block.call(index)}
    end
  end

  alias_method :shallow_dup, :dup

  #Create a duplicate of this array.
  #<br>Warning
  #* The rdoc tool messes this up. shallow_dup is NOT an alias for this
  #  dup, but rather the original system implementation of dup. This dup,
  #  overrides the default dup and calls shallow_dup as part of its processing.
  def dup
    other = self.shallow_dup
    other.array_specs = @array_specs.dup
    other.array_data  = @array_data.dup
    other
  end

  #Construct a \FlexArray using other as a template or data source.
  #<br>Parameters:
  #* array_specs - The specification of the flex array subscript limits.
  #  These can either be integers, in which case the limits are 0...n or
  #  they can be ranges of integers, in which case the limits are those
  #  of the range, or they can be an array of integers and/or ranges of
  #  integers to represent arrays of more than one dimension.
  #* other - The array or flex array that is the source of the data.
  #<br>Note:
  #* To make a copy of a flex array, use dup instead.
  def self.new_from(array_specs, other)
    iterator = other.array_data.cycle
    FlexArray.new(array_specs) {iterator.next}
  end

  #Construct a \FlexArray using a all or a portion of portion of another
  #\FlexArray as a data source.
  #<br>Parameters
  #* array_specs - The specification of the flex array subscript limits.
  #  These can either be integers, in which case the limits are 0...n or
  #  they can be ranges of integers, in which case the limits are those
  #  of the range, or they can be an array of integers and/or ranges of
  #  integers to represent arrays of more than one dimension.
  #* other - The flex array source of the data used to build this flex
  #  array. If no limits or other_indexes are specified, the limits of the
  #  other array are used instead.
  #* selection - The indexes of the required sub-set of data to use
  #  in setting up the new array.
  #<br>Notes:
  #* If the entire source array is to be used, use new_from instead.
  #* To make a copy of a flex array, use dup instead.
  def self.new_from_selection(array_specs, other, selection)
    iterator = other.select_cycle(selection)
    FlexArray.new(array_specs) {iterator.next}
  end

  #Construct a \FlexArray as a duplicate of a source array or flex array.
  #<br>Parameters
  #* other - the array or flex array that is the source.
  #<br>Returns
  #* A flex array.
  #<br>Note
  #* The data array of the new flex array is a reference to the source array.
  def self.new_from_array(other)
    result = FlexArray.new(0)
    result.array_specs = other.array_specs.dup
    result.array_data = other.array_data
    result
  end
end