# The flexible array indexing and related methods.

class FlexArray
  # Retrieve the selected data from the flex array.
  def [](*indexes)
    validate_index_count(indexes)
    result = []
    process_indexes(indexes) {|_index, posn| result << @array_data[posn]}
    result.length == 1 ? result[0] : result
  end

  # Store the value data into the flex array.
  def []=(*indexes, value)
    validate_index_count(indexes)
    source = value.in_array.cycle
    process_indexes(indexes) {|_index, posn| @array_data[posn] = source.next}
    value
  end
end