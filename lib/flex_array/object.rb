#Extensions to Object needed to support flex array.
class Object
  #Fail with message since the array dimension is invalid.
  #<br>Parameters
  #* _stride - unused, required to maintain signature.
  #<br>Returns
  #* Nothing, always fails.
  def to_spec_component(_stride)
    fail ArgumentError, "Invalid flex array dimension: #{self.inspect}"
  end

  #Convert this object to an range index against the spec.
  #<br>Parameters
  #* spec - The spec component used to validate this index.
  #<br>Returns
  #* A range.
  #<br>Exceptions
  #* IndexError if the range is not valid.
  def to_index_range(spec)
    if self == :all
      spec.range
    else
      fail IndexError, "Invalid subscript: #{self.inspect}"
    end
  end

end
