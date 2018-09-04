# Extensions to Array needed to support flex array.

class Array
  # Get the specifications of the array index values.
  def limits
    [0...self.length]
  end

  # Quick access to the limits for internal use.
  def array_specs
    SpecArray.new([0...self.length])
  end

  # Quick access to the array data for internal use.
  def array_data
    self
  end

  # Convert this array to an range index against the spec.
  def to_index_range(spec)
    spec_max = spec.max

    self.collect do |value|
      value = Integer(value)
      value = spec_max + value + 1 if value < 0

      unless spec === value
        fail IndexError, "Subscript invalid or out of range: #{self.inspect}"
      end

      value
    end
  end

  # Return this flex array as a flex array!
  def to_flex_array
    FlexArray.new_from_array(self)
  end

end
