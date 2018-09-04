# Append method support for the flex array.

class FlexArray
  # Append to the flex array.
  def << (data)
    fail "Cannot append to a transposed array." if @transposed
    specs = get_append_specs(data = data.in_array)
    @array_data += data.array_data
    @array_specs.enlarge(specs[0].span)
    self
  end

  private
  # Extract and validate the append array_spec
  def get_append_specs(data)
    spec_len = (specs = data.array_specs).length

    if dimensions == spec_len+1
      specs = specs.dup.insert(0, SpecComponent.new(0...1, nil))
    elsif dimensions != spec_len
      fail ArgumentError, "Incompatible dimensionality error on <<."
    end

    (1...dimensions).each do |index|
      unless @array_specs[index].span == specs[index].span
        fail ArgumentError, "Dimension mismatch error on <<."
      end
    end

    specs
  end
end