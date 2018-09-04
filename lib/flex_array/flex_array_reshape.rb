# The flexible array class reshape and related methods.

class FlexArray
  # Return a copy of this flex array, recast in a new shape, dropping or
  # repeating data elements as required.
  def reshape(array_specs)
    iterator = @array_data.cycle
    FlexArray.new(array_specs) {iterator.next}
  end

  # Recast this flex array in a new shape, dropping or repeating data elements
  # as required.
  def reshape!(array_specs)
    temp = self.reshape(array_specs)
    @array_specs, @array_data = temp.array_specs, temp.array_data
    self
  end

  # Convert the flex array to a simple array. Contained arrays are not affected.
  def to_a
    @array_data.dup
  end
end
