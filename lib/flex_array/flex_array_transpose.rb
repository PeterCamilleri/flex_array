#* flex_array_transpose.rb - The flexible array class transpose and related methods.
class FlexArray
  #Transpose the specified dimensions. This may change the "shape" of the array
  #if the transposed dimensions were of different limits.
  #<br>Returns
  #* The flex array transposed.
  #<br>Note
  #* Transposing an array disables the speed-up for processing the array with
  #  an index of [:all].
  def transpose!(dim_a, dim_b)
    validate_dimension(dim_a)
    validate_dimension(dim_b)
    @array_specs[dim_a], @array_specs[dim_b] = @array_specs[dim_b], @array_specs[dim_a]
    @transposed = @array_specs.transposed?
    self
  end

  #Return a reference to this array's data with the specified dimensions
  #transposed. This may change the "shape" of the array if the transposed
  #dimensions were of different limits.
  #<br>Returns
  #* The flex array transposed.
  #<br>Note
  #* Transposing an array disables the speed-up for processing the array with
  #  an index of [:all].
  def transpose(dim_a, dim_b)
    FlexArray.new_from_array(self).transpose!(dim_a, dim_b)
  end

end