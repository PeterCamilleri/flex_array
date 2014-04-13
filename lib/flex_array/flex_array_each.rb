#* flex_array_each.rb - The flexible array class each and related methods.
# :reek:RepeatedConditional - @transposed determines if short cuts are allowed.
class FlexArray
  include Enumerable

  #Retrieve data from the array endlessly repeating as needed.
  #<br>Parameters
  #* count - The number of times to cycle through the flex array. Defaults to
  #  cycling forever.
  #* block - The optional block to be executed for each selected array element.
  #  The return value is the last value returned by the block. If the block
  #  is not present, then an enumerator object is returned.
  #<br>Returns
  #* nil or an enumerator if no block is provided.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  #<br>Endemic Code Smells
  #* :reek:NestedIterators
  def cycle(count = FOREVER, &block)
    if block_given?
      if @transposed && length > 0
        count.times do
          process_all do |_index, posn|
            block.call(@array_data[posn])
          end
        end

        nil
      else
        @array_data.cycle(count.to_i, &block)
      end
    else
      self.to_enum(:cycle, count)
    end
  end

  #Retrieve data from a subset of the flex array endlessly repeating as needed.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has
  #  dimensions. See [] for more details. Note that since indexes is NOT
  #  a splat parameter, it must be passed as an array explicitly.
  #* count - The number of times to cycle through the flex array. Defaults to
  #  cycling forever.
  #* block - The optional block to be executed for each selected array element.
  #  The return value is the last value returned by the block. If the block
  #  is not present, then an enumerator object is returned.
  #<br>Returns
  #* nil or an enumerator if no block is provided.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  #<br>Endemic Code Smells
  #* :reek:NestedIterators
  def select_cycle(indexes, count = FOREVER, &block)
    validate_index_count(indexes)

    if block_given?
      unless empty?
        count.times do
          process_indexes(indexes) do |_index, posn|
            block.call(@array_data[posn])
          end
        end
      end

      nil
    else
      self.to_enum(:select_cycle, indexes, count)
    end
  end

  #Process the standard each operator.
  #<br>Parameters
  #* block - The optional block to be executed for each selected array element.
  #<br>Returns
  #* If the block is not present, then an enumerator object is returned.
  #  Otherwise the flex array is returned.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  def each(&block)
    if block_given?
      if @transposed
        process_all {|_index, posn| block.call(@array_data[posn])}
      else
        @array_data.each(&block)
      end

      self
    else
      self.to_enum(:each)
    end
  end

  #Process the enhanced select_each operator.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has
  #  dimensions. See [] for more details. Note that since indexes is NOT
  #  a splat parameter, it must be passed as an array explicitly
  #* block - The optional block to be executed for each selected array element.
  #<br>Returns
  #* If the block is not present, then an enumerator object is returned.
  #  Otherwise the flex array is returned.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  def select_each(indexes, &block)
    validate_index_count(indexes)

    if block_given?
      process_indexes(indexes) {|_index, posn| block.call(@array_data[posn])}
      self
    else
      self.to_enum(:select_each, indexes)
    end
  end

  #Process the standard each_with_index operator.
  #<br>Parameters
  #* block - The optional block to be executed for each selected array element.
  #<br>Returns
  #* If the block is not present, then an enumerator object is returned.
  #  Otherwise the flex array is returned.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  #* index - An array with the full index of the selected value.
  def each_with_index(&block)
    if block_given?
      process_all {|index, posn| block.call(@array_data[posn], index)}
      self
    else
      self.to_enum(:each_with_index)
    end
  end

  #Process the enhanced select_each_with_index operator.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has
  #  dimensions. See [] for more details. Note that since indexes is NOT
  #  a splat parameter, it must be passed as an array explicitly.
  #* block - The optional block to be executed for each selected array element.
  #<br>Returns
  #* If the block is not present, then an enumerator object is returned.
  #  Otherwise the flex array is returned.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  #* index - An array with the full index of the selected value.
  def select_each_with_index(indexes, &block)
    validate_index_count(indexes)

    if block_given?
      process_indexes(indexes) {|index, posn| block.call(@array_data[posn], index)}
      self
    else
      self.to_enum(:select_each_with_index, indexes)
    end
  end

  #A specialized each variant that passes the low level data, the index
  #and the position to the block.
  #<br>Parameters
  #* block - The optional block to be executed for each selected array element.
  #  The return value is the last value returned by the block. If the block
  #  is not present, then an enumerator object is returned.
  #<br>Returns
  #* If the block is not present, then an enumerator object is returned.
  #  Otherwise the flex array is returned.
  #<br>Block Arguments
  #* index - An array with the full index of the selected value.
  #* posn - The position of the data in the low level data store.
  def _each_raw(&block)
    if block_given?
      process_all {|index, posn| block.call(index, posn)}
      self
    else
      self.to_enum(:_each_raw)
    end
  end

  #An enhanced specialized each variant that passes the low level data,
  #the index and the position to the block.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has
  #  dimensions. See [] for more details. Note that since indexes is NOT
  #  a splat parameter, it must be passed as an array explicitly.
  #* block - The optional block to be executed for each selected array element.
  #  The return value is the last value returned by the block. If the block
  #  is not present, then an enumerator object is returned.
  #<br>Returns
  #* If the block is not present, then an enumerator object is returned.
  #  Otherwise the flex array is returned.
  #<br>Block Arguments
  #* index - An array with the full index of the selected value.
  #* posn - The position of the data in the low level data store.
  def _select_each_raw(indexes, &block)
    validate_index_count(indexes)

    if block_given?
      process_indexes(indexes) {|index, posn| block.call(index, posn)}
      self
    else
      self.to_enum(:_select_each_raw, indexes)
    end
  end

  alias_method :flatten_collect, :collect

  #The flex array version of collect that returns a flex array.
  #<br>Parameters
  #* block - The optional block to be executed for each selected array element.
  #<br>Returns
  #* An array of the computed objects retuned by the block.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  def collect(&block)
    result = self.dup
    result.collect!(&block)
  end

  #The flex array version of collect that accepts an optional set of indexes
  #to select the data being collected into a flex array.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has
  #  dimensions. See [] for more details. Note that since indexes is NOT
  #  a splat parameter, it must be passed as an array explicitly.
  #* block - The optional block to be executed for each selected array element.
  #<br>Returns
  #* An array of the computed objects retuned by the block.
  #  If the block is not present, an enumerator object is returned.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  def select_collect(indexes, &block)
    result = self.dup
    result.select_collect!(indexes, &block)
  end

  #The flex array version of collect that accepts an optional set of indexes
  #to select the data being collected into a standard array.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has
  #  dimensions. See [] for more details. Note that since indexes is NOT
  #  a splat parameter, it must be passed as an array explicitly.
  #* block - The optional block to be executed for each selected array element.
  #<br>Returns
  #* An array of the computed objects retuned by the block.
  #  If the block is not present, an enumerator object is returned.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  def select_flatten_collect(indexes, &block)
    validate_index_count(indexes)

    if block_given?
      result = []
      process_indexes(indexes) {|_index, posn| result << block.call(@array_data[posn])}
      result
    else
      self.to_enum(:select_collect, indexes)
    end
  end

  #The flex array version of collect!
  #<br>Parameters
  #* block - The *required* block to be executed for each selected array element.
  #  The return value is the last value returned by the block. If the block
  #  is not present, an enumerator object is returned.
  #<br>Returns
  #* self
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  def collect!(&block)
    fail ArgumentError, "A block is required." unless block_given?

    if @transposed
      process_all {|_index, posn| @array_data[posn] =
        block.call(@array_data[posn])}
    else
      @array_data = @array_data.collect(&block)
    end

    self
  end

  #The enhanced flex array version of collect! that accepts a set of indexes
  #to select the data being collected.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has
  #  dimensions. See [] for more details. Note that since indexes is NOT
  #  a splat parameter, it must be passed as an array explicitly.
  #* block - The *required* block to be executed for each selected array element.
  #  The return value is the last value returned by the block. If the block
  #  is not present, an enumerator object is returned.
  #<br>Returns
  #* self
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  def select_collect!(indexes, &block)
    fail ArgumentError, "A block is required." unless block_given?
    validate_index_count(indexes)

    process_indexes(indexes) {|_index, posn| @array_data[posn] =
      block.call(@array_data[posn])}

    self
  end

  #The flex array version of find_index. This returns the
  #coordinates of the first object that matches the search object or is
  #flagged true by the search block.
  #<br>Parameters
  #* object - The optional value to search for.
  #* block - The optional block to be executed for each selected array element.
  #  If the block or object are not present, an enumerator object is returned.
  #<br>Returns
  #* The index of the first place that matched or nil if none matched.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  def find_index(value = nil, &block)
    blk = get_find_block(value, &block)

    if blk
      process_all do |index, posn|
        if blk.call(@array_data[posn])
          return index
        end
      end

      nil
    else
      self.to_enum(:find_index)
    end
  end

  #The enhanced flex array version of find_index. This returns the
  #coordinates of the first object that matches the search object or is
  #flagged true by the search block.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has
  #  dimensions. See [] for more details. Note that since indexes is NOT
  #  a splat parameter, it must be passed as an array explicitly.
  #* object - The optional value to search for.
  #* block - The optional block to be executed for each selected array element.
  #  If the block or object are not present, an enumerator object is returned.
  #<br>Returns
  #* The index of the first place that matched or nil if none matched.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  def select_find_index(indexes, value = nil, &block)
    validate_index_count(indexes)
    blk = get_find_block(value, &block)

    if blk
      process_indexes(indexes) do |index, posn|
        if blk.call(@array_data[posn])
          return index
        end
      end

      nil
    else
      self.to_enum(:select_find_index, indexes)
    end
  end

  #The improved flex array version of find_index. This returns the
  #coordinates of objects that match the search object or are
  #flagged true by the search block.
  #<br>Parameters
  #* object - The optional value to search for.
  #* block - The optional block to be executed for each selected array element.
  #  If the block or object are not present, an enumerator object is returned.
  #<br>Returns
  #* An array of the indexes of the places that matched.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  def find_indexes(value = nil, &block)
    blk, result = get_find_block(value, &block), []

    if blk
      process_all do |index, posn|
        if blk.call(@array_data[posn])
          result << index.dup
        end
      end

      result
    else
      self.to_enum(:find_indexes)
    end
  end

  #The enhanced and improved flex array version of find_index. This returns the
  #coordinates of objects that match the search object or are
  #flagged true by the search block.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has
  #  dimensions. See [] for more details. Note that since indexes is NOT
  #  a splat parameter, it must be passed as an array explicitly.
  #* object - The optional value to search for.
  #* block - The optional block to be executed for each selected array element.
  #  If the block or object are not present, an enumerator object is returned.
  #<br>Returns
  #* An array of the indexes of the places that matched.
  #<br>Block Arguments
  #* value - Each value selected by the iteration.
  def select_find_indexes(indexes, value = nil, &block)
    validate_index_count(indexes)
    blk, result = get_find_block(value, &block), []

    if blk
      process_indexes(indexes) do |index, posn|
        if blk.call(@array_data[posn])
          result << index.dup
        end
      end

      result
    else
      self.to_enum(:select_find_index, indexes)
    end
  end

  private

  #A helper method to determine which block to use in the find_index family.
  #<br>Returns
  #* The block to use or nil.
  #<br>Endemic Code Smells
  #* :reek:NilCheck
  def get_find_block(value, &block)
    if block_given?
      block
    elsif value.nil?
      nil
    else
      lambda {|obj| obj == value }
    end
  end
end
