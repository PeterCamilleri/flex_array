# Some flexible array class index validation routines.

class FlexArray
  # Is this array compatible with other?
  def compatible?(other)
    @array_specs == other.array_specs
  rescue
    false
  end

  private

  # Validate the dimensionality of the indexes passed in.
  def validate_index_count(indexes)
    unless indexes == [:all]
      if dimensions != indexes.length
        fail ArgumentError, "Incorrect number of indexes: #{dimensions} expected."
      end
    end
  end

  # Is this a valid dimension selector?
  def validate_dimension(dim)
    unless (0...dimensions) === dim
      fail ArgumentError, "Invalid dimension selector: #{dim}"
    end
  end
end
