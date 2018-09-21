# Support for each and related methods for the flex array.

class FlexArray
  include Enumerable

  # Retrieve data from the array endlessly repeating as needed.
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

  # Retrieve data from a subset of the flex array endlessly repeating as needed.
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

  # Process the standard each operator.
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

  # Process the enhanced select_each operator.
  def select_each(indexes, &block)
    validate_index_count(indexes)

    if block_given?
      process_indexes(indexes) {|_index, posn| block.call(@array_data[posn])}
      self
    else
      self.to_enum(:select_each, indexes)
    end
  end

  # Process the standard each_with_index operator.
  def each_with_index(&block)
    if block_given?
      process_all {|index, posn| block.call(@array_data[posn], index)}
      self
    else
      self.to_enum(:each_with_index)
    end
  end

  # Process the enhanced select_each_with_index operator.
  def select_each_with_index(indexes, &block)
    validate_index_count(indexes)

    if block_given?
      process_indexes(indexes) {|index, posn| block.call(@array_data[posn], index)}
      self
    else
      self.to_enum(:select_each_with_index, indexes)
    end
  end

  # A specialized each variant that passes the low level data, the index
  # and the position to the block.
  def _each_raw(&block)
    if block_given?
      process_all {|index, posn| block.call(index, posn)}
      self
    else
      self.to_enum(:_each_raw)
    end
  end

  # An enhanced specialized each variant that passes the low level data,
  # the index and the position to the block.
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

  # The flex array version of collect that returns a flex array.
  def collect(&block)
    result = self.dup
    result.collect!(&block)
  end

  # The flex array version of collect that accepts an optional set of indexes
  # to select the data being collected into a flex array.
  def select_collect(indexes, &block)
    result = self.dup
    result.select_collect!(indexes, &block)
  end

  # The flex array version of collect that accepts an optional set of indexes
  # to select the data being collected into a standard array.
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

  # The flex array version of collect!
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

  # The enhanced flex array version of collect! that accepts a set of indexes
  # to select the data being collected.
  def select_collect!(indexes, &block)
    fail ArgumentError, "A block is required." unless block_given?
    validate_index_count(indexes)

    process_indexes(indexes) {|_index, posn| @array_data[posn] =
      block.call(@array_data[posn])}

    self
  end

  # The flex array version of find_index. This returns the coordinates of the
  # first object that matches the search object or is flagged true by the
  # search block.
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

  # The enhanced flex array version of find_index. This returns the coordinates
  # of the first object that matches the search object or is flagged true by
  # the search block.
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

  # The improved flex array version of find_index. This returns the coordinates
  # of objects that match the search object or are flagged true by the search
  # block.
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

  # The enhanced and improved flex array version of find_index. This returns
  # the coordinates of objects that match the search object or are flagged true
  # by the search block.
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

  # A helper method to determine which block to use in the find_index family.
  def get_find_block(value, &block)
    if block_given?
      block
    else
      lambda {|obj| obj == value }
    end
  end
end
