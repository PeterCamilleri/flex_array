#Extensions to Range needed to support flex array.
class Range
  #Convert this integer to a limits component.
  #<br>Parameters
  #* stride - the number of cells separating data with adjacent indexes.
  #<br>Returns
  #* A SpecComponent object with the same range as self.
  def to_spec_component(stride)
    min = self.min

    if self == (0...0)
      SpecComponent.new(0...0, stride)
    elsif !self.none? && min.is_a?(Integer) && (min >= 0) && self.max.is_a?(Integer)
      SpecComponent.new(self, stride)
    else
      fail ArgumentError, "Invalid flex array dimension: #{self.inspect}"
    end
  end

  #Convert this range to an range index against the spec.
  #<br>Parameters
  #* spec - The spec component used to validate this index.
  #<br>Returns
  #* A range.
  #<br>Exceptions
  #* IndexError if the range is not valid.
  def to_index_range(spec)
    self_min, self_max, spec_max = self.min, self.max, spec.max

    if self_min < 0 && self_max < 0
      alter_ego = (spec_max + self_min + 1)..(spec_max + self_max + 1)
    else
      alter_ego = self
    end

    if spec === alter_ego.min && spec === alter_ego.max
      alter_ego
    else
      fail IndexError, "Subscript out of range: #{self.inspect}"
    end
  end
end