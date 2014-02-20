#* flex_array_index.rb - The flexible array indexing and related methods.
class FlexArray
  #Retrieve the selected data from the \FlexArray.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has 
  #  dimensions. These entries may be an integer that is in the bounds of
  #  the range limit of that dimension, or it can be a range where the start
  #  and end of the range are in the bounds of the range limit of that 
  #  dimension, or it can be the symbol :all for all of the possible values
  #  of that dimension.
  #<br>Returns
  #* The data selected by the index or an array of data if the index selects
  #  more than one cell.  
  #<br>Note 
  #* If the indexes parameter equals a single :all this maps to all
  #  elements of the array, regardless of its dimensionality.
  def [](*indexes)
    validate_all_or_index_count(indexes)
    result = []
    process_indexes(indexes) {|_index, posn| result << @array_data[posn]}
    result.length == 1 ? result[0] : result
  end

  #Store the value data into the \FlexArray.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has 
  #  dimensions. These entries may be an integer that is in the bounds of
  #  the range limit of that dimension, or it can be a range where the start
  #  and end of the range are in the bounds of the range limit of that 
  #  dimension, or it can be the symbol :all for all of the possible values
  #  of that dimension. 
  #* value - A value to be stored in the selected array entries.
  #<br>Returns
  #* The value stored in the array.
  #<br>Note 
  #* If the indexes parameter equals a single :all this maps to all
  #  elements of the array, regardless of its dimensionality.
  def []=(*indexes, value)
    validate_all_or_index_count(indexes)
    source = value.in_array.cycle
    process_indexes(indexes) {|_index, posn| @array_data[posn] = source.next}
    value
  end
end