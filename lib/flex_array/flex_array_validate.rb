#* flex_array_validate.rb - The flexible array class index validation routines.
class FlexArray
  #Is this array compatible with other?
  #<br>Parameters
  #* other - The object being tested for compatibility.
  #<br>Returns
  #* true if the arrays are compatible.
  def compatible?(other)
    @array_specs == other.array_specs
  end

  private
  
  #Validate the dimensionality of the indexes passed in.
  #<br>Parameters
  #* indexes - An array of indexes to be validated.
  #<br>Returns
  #* true if the indexes value is [:all] and the array is not transposed.
  #<br>Exceptions
  #* ArgumentError - raised on invalid dimensionality.
  def validate_all_or_index_count(indexes)
    if indexes == [:all]
      !@transposed
    elsif @dimensions != indexes.length
      fail ArgumentError, "Incorrect number of indexes: #{@dimensions} expected."
    end
  end
  
  #Is this a valid dimension selector?
  #<br>Exceptions
  #* ArgumentError - raised on invalid dimension.
  def validate_dimension(dim)
    unless (0...@dimensions) === dim
      fail ArgumentError, "Invalid dimesnsion selector: #{dim}"
    end
  end
end
