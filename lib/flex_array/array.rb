#Extensions to Array needed to support flex array.
class Array
  #Get the specifications of the array index values.
  #<br>Returns
  #* An array with one range in it.
  def limits
    [0...self.length]
  end

  #Quick access to the limits for internal use.
  #<br>Returns
  #* An array with one spec component in it.
  def array_specs
    SpecArray.new([0...self.length])
  end

  #Quick access to the array data for internal use.
  #<br>Returns
  #* An array -- self
  def array_data
    self
  end

  #Convert this array to an range index against the spec.
  #<br>Parameters
  #* spec - The spec component used to validate this index.
  #<br>Returns
  #* A range.
  #<br>Exceptions
  #* IndexError if the range is not valid.
  def to_index_range(spec)
    self_min, self_max, spec_max = Integer(self[0]), Integer(self[1]), spec.max
    self_min = spec_max + self_min + 1 if self_min < 0
    self_max = spec_max + self_max + 1 if self_max < 0

    if self.length == 2 && self_min <= self_max && spec === self_min && spec === self_max
      self_min..self_max
    else
      fail IndexError, "Subscript invalid or out of range: #{self.inspect}"
    end
  end

  #Return this flex array as a flex array!
  #<br>Returns
  #* A flex array that references this array.
  #<br>Note
  #* To avoid a shared reference, use my_array.dup.to_flex_array instead.
  def to_flex_array
    FlexArray.new_from_array(self)
  end
end