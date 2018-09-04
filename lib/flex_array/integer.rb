# Extensions to Integer needed to support flex array.

class Integer
  # Convert this integer to a limits component.
  def to_spec_component(stride)
    if self >= 0
      SpecComponent.new(0...self, stride)
    else
      fail ArgumentError, "Invalid flex array dimension: #{self.inspect}"
    end
  end

  # Convert this integer to an range index against the spec.
  def to_index_range(spec)
    alter_ego = (self >= 0) ? self : (spec.max + self + 1)

    if spec === alter_ego
      alter_ego..alter_ego
    else
      fail IndexError, "Subscript out of range: #{self.inspect}"
    end
  end
end