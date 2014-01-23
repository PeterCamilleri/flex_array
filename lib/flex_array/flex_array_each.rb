#* flex_array_each.rb - The flexible array class each and related methods.
class FlexArray
  #Process the standard :each operator.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has 
  #  dimensions. See [] for more details. Note that since indexes is NOT
  #  a splat parameter, it must be passed as an array explicitly. If omitted
  #  or passed in as [:all] all elements of the array are processed.
  #* block - The optional block to be executed for each selected array element.
  #  The return value is the last value returned by the block. If the block 
  #  is not present, an enumerator object is returned.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  def each(indexes=[:all], &block)
    if validate_all_or_index_count(indexes)
      @array_data.each(&block)
    elsif block_given?
      process_indexes(indexes) {|_index, posn| block.call(@array_data[posn])}
    else
      Enumerator.new do |yielder|
        process_indexes(indexes) {|_index, posn| yielder.yield(@array_data[posn])}
      end
    end
  end

  #Retrieve data from the array endlessly repeating as needed.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has 
  #  dimensions. See [] for more details. Note that since indexes is NOT
  #  a splat parameter, it must be passed as an array explicitly. If omitted
  #  or passed in as [:all] all elements of the array are processed.
  #* block - The optional block to be executed for each selected array element.
  #  The return value is the last value returned by the block. If the block 
  #  is not present, then an enumerator object is returned.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.  
  def cycle(indexes=[:all], &block)
    if validate_all_or_index_count(indexes)
      @array_data.cycle(&block)
    elsif block_given?
      loop {process_indexes(indexes) {|_index, posn| block.call(@array_data[posn])}}
    else
      Enumerator.new do |yielder|
        loop {process_indexes(indexes) {|_index, posn| yielder.yield(@array_data[posn])}}
      end
    end
  end
  
  #Process the standard :each_with_index operator.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has 
  #  dimensions. See [] for more details. Note that since indexes is NOT
  #  a splat parameter, it must be passed as an array explicitly. If omitted
  #  or passed in as [:all] all elements of the array are processed.
  #* block - The optional block to be executed for each selected array element.
  #  The return value is the last value returned by the block. If the block 
  #  is not present, then an enumerator object is returned.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  #* index - An array with the full index of the selected value.
  def each_with_index(indexes=[:all], &block)
    validate_all_or_index_count(indexes)

    if block_given?
      process_indexes(indexes) {|index, posn| block.call(@array_data[posn], index)}
    else
      Enumerator.new do |yielder|
        process_indexes(indexes) {|index, posn| yielder.yield(@array_data[posn], index)}
      end
    end
  end
  
  #A specialized each variant that passes the low level data, the index 
  #and the position to the block.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has 
  #  dimensions. See [] for more details. Note that since indexes is NOT
  #  a splat parameter, it must be passed as an array explicitly. If omitted
  #  or passed in as [:all] all elements of the array are processed.
  #* block - The optional block to be executed for each selected array element.
  #  The return value is the last value returned by the block. If the block 
  #  is not present, then an enumerator object is returned.
  #<br>Block Arguments
  #* data - A reference to the low level data store.
  #* index - An array with the full index of the selected value.
  #* posn - The position of the data in the low level data store.
  def _each_raw(indexes=[:all], &block)
    validate_all_or_index_count(indexes)

    if block_given?
      process_indexes(indexes) {|index, posn| block.call(@array_data, index, posn)}
    else
      Enumerator.new do |yielder|
        process_indexes(indexes) {|index, posn| yielder.yield(@array_data, index, posn)}
      end
    end
  end
end