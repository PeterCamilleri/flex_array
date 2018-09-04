# The flexible array class index processing routines.
class FlexArray
  private

  # Process a \FlexArray index array. This is the heart of the flex array
  # indexing process.
  def process_indexes(indexes, &block)
    current = Array.new(dimensions, 0)

    if indexes == [:all]
      process_all_worker(0, 0, current, &block)
    else
      specs = @array_specs.each

      checked = indexes.collect do |index|
        index.to_index_range(specs.next)
      end

      process_indexes_worker(0, 0, checked, current, &block)
    end
  end

  # The worker bee for process_indexes.
  def process_indexes_worker(depth, posn, indexes, current, &block)
    if depth == dimensions                 # Is there more work to do?
      block.call(current, posn)            # Index ready, call the block.
    else
      spec = @array_specs[depth]           # Get the current specification.
      min, stride = spec.min, spec.stride  # Extract the relevant info.

      indexes[depth].each do |index|       # Iterate over the range.
        current[depth] = index             # Update the current index.

        # Process the next component in the array index.
        process_indexes_worker(depth+1,
                               posn + (index-min) * stride,
                               indexes,
                               current,
                               &block)
      end
    end
  end

  # Special case where all of the array is being processed.
  def process_all(&block)
    current = Array.new(dimensions, 0)
    process_all_worker(0, 0, current, &block)
  end

  # The worker bee for process_all.
  def process_all_worker(depth, posn, current, &block)
    if depth == dimensions                 # Is there more work to do?
      block.call(current, posn)            # Index ready, call the block.
    else
      spec = @array_specs[depth]           # Get the current specification.
      stride = spec.stride

      spec.each do |index|                 # Iterate over the range.
        current[depth] = index             # Update the current index.

        # Process the next component in the array specification.
        process_all_worker(depth+1, posn, current, &block)
        posn += stride                     # Step to the next position.
      end
    end
  end
end