# Extensions to Range needed to support flex array.

class Range
  # Convert this integer to a limits component.
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

  # Convert this range to an range index against the spec.
  def to_index_range(spec)
    self_min, self_max, spec_max = self.begin, self.end, spec.max
    self_max -= 1 if self_max > 0 && self.exclude_end?

    self_min = spec_max + self_min + 1 if self_min < 0
    self_max = spec_max + self_max + 1 if self_max < 0

    if spec === self_min && spec === self_max && self_min < self_max
      self_min..self_max
    else
      fail IndexError, "Subscript out of range: #{self.inspect}"
    end
  end
end