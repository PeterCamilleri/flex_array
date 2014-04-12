#Extensions to Integer needed to support flex array.
class Integer
  #Convert this integer to a limits component.
  #<br>Parameters
  #* stride - the number of cells separating data with adjacent indexes.
  #<br>Returns
  #* A SpecComponent object of 0...self
  def to_spec_component(stride)
    if self >= 0
      SpecComponent.new(0...self, stride)
    else
      fail ArgumentError, "Invalid flex array dimension: #{self.inspect}"
    end
  end

  #Convert this integer to an range index against the spec.
  #<br>Parameters
  #* spec - The spec component used to validate this index.
  #<br>Returns
  #* A range.
  #<br>Exceptions
  #* IndexError if the range is not valid.
  def to_index_range(spec)
    alter_ego = (self >= 0) ? self : (spec.max + self + 1)

    if spec === alter_ego
      alter_ego..alter_ego
    else
      fail IndexError, "Subscript out of range: #{self.inspect}"
    end
  end
end