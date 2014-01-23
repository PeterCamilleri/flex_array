#* flex_array_reshape.rb - The flexible array class reshape and related methods.
class FlexArray
  #Return a copy of this \FlexArray, recast in a new shape, dropping or 
  #repeating data elements as required.
  #<br>Parameters
  #* array_specs - The specification of the flex array subscript limits. 
  #  These can either be integers, in which case the limits are 0...n or 
  #  they can be ranges of integers, in which case the limits are those 
  #  of the range, or they can be an array of integers and/or ranges of 
  #  integers to represent arrays of more than one dimension.
  #<br>Returns
  #* The reshaped flexible array.
  def reshape(array_specs)
    iterator = @array_data.cycle
    FlexArray.new(array_specs) {iterator.next}
  end

  #Recast this \FlexArray in a new shape, dropping or 
  #repeating data elements as required.
  #<br>Parameters
  #* array_specs - The specification of the flex array subscript limits. 
  #  These can either be integers, in which case the limits are 0...n or 
  #  they can be ranges of integers, in which case the limits are those 
  #  of the range, or they can be an array of integers and/or ranges of 
  #  integers to represent arrays of more than one dimension.
  #<br>Returns
  #* The reshaped, flexible array.
  def reshape!(array_specs)
    iterator = @array_data.cycle
    temp = FlexArray.new(array_specs) {iterator.next}
    @array_specs, @array_data, @dimensions = 
      temp.array_specs, temp.array_data, temp.dimensions
    self
  end

  #Unravel the multi-dimensional structure, and any contained arrays into 
  #a simple array.
  def flatten
    @array_data.flatten
  end

  #Convert the flex array to a simple array. Contained arrays are not affected.  
  def to_a
    @array_data.dup
  end
end
