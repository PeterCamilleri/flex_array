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
    all_in = validate_all_or_index_count(indexes)

    if block_given?
      if all_in
        @array_data.each(&block)
      else
        process_indexes(indexes) {|_index, posn| block.call(@array_data[posn])}
      end

      self
    else
      self.to_enum(:each, indexes)
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
    all_in = validate_all_or_index_count(indexes)

    if block_given?
      if all_in
        @array_data.cycle(&block)
      else
        loop {process_indexes(indexes) {|_index, posn| block.call(@array_data[posn])}}
      end

      self
    else
      self.to_enum(:cycle, indexes)
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
      self.to_enum(:each_with_index, indexes)
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
      self.to_enum(:_each_raw, indexes)
    end
  end

  #The flex array version of collect that accepts an optional set of indexes
  #to select the data being collected.
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
  def collect(indexes=[:all], &block)
    all_in = validate_all_or_index_count(indexes)

    if block_given?
      if all_in
        @array_data.collect(&block)
      else
        result = []
        process_indexes(indexes) {|_index, posn| result << block.call(@array_data[posn])}
        result
      end
    else
      self.to_enum(:collect, indexes)
    end
  end

  #The flex array version of collect that accepts an optional set of indexes
  #to select the data being collected.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has
  #  dimensions. See [] for more details. Note that since indexes is NOT
  #  a splat parameter, it must be passed as an array explicitly. If omitted
  #  or passed in as [:all] all elements of the array are processed.
  #* block - The *required* block to be executed for each selected array element.
  #  The return value is the last value returned by the block. If the block
  #  is not present, an enumerator object is returned.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  def collect!(indexes=[:all], &block)
    unless block_given?
      fail ArgumentError, "A block is required."
    end

    if validate_all_or_index_count(indexes)
      @array_data = @array_data.collect(&block)
    else
      process_indexes(indexes) {|_index, posn| @array_data[posn] =
        block.call(@array_data[posn])}
    end

    self
  end
end
