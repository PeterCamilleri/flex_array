#* flex_array_process.rb - The flexible array class index processing routines.
class FlexArray
  private
  #Process a \FlexArray index array. This is the heart of the \FlexArray
  #indexing process.
  #<br>Parameters
  #* indexes - An array with as many entries as the flexible array has 
  #  dimensions. See [] for more details. Note that since indexes is NOT
  #  a splat parameter, it must be passed as an array explicitly. If passed
  #  in as [:all] all elements of the array are processed.
  #* block - a block to be called for each value selected by this process.
  #<br>Block Arguments
  #* current - An array with one element per dimension with the fully qualified 
  #  index of the element being accessed. 
  #* posn - The position of the element being accessed in the data array.
  def process_indexes(indexes, &block)
    current = Array.new(@dimensions, 0)
    
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

  #The worker bee for process_indexes.
  #<br>Parameters
  #* depth - The index of the dimension being processed.
  #* posn - The partially computed position of the element being accessed 
  #  in the data array.
  #* indexes - An array of array indexes. See the method [] for details on 
  #  what sorts of things these can be.
  #* current - The partial fully qualified index of the element being accessed.
  #* block - A block to be called for each value selected by this process.
  #<br>Block Arguments
  #* current - An array with one element per dimension with the fully qualified 
  #  index of the element being accessed. 
  #* posn - The position of the element being accessed in the data array.
  #<br>Note
  #This is a recursive function. The recursion runs for index in 0..#dimensions
  def process_indexes_worker(depth, posn, indexes, current, &block)
    if depth == @dimensions
      block.call(current, posn)
    else
      spec   = @array_specs[depth]
      range  = indexes[depth]
      posn  += spec.index_step(range.min)
      stride = spec.stride
      
      range.each do |index|
        current[depth] = index
        process_indexes_worker(depth+1, posn, indexes, current, &block)
        posn += stride
      end
    end
  end
  
  #Special case where all of the array is being processed.
  #<br>Parameters
  #* block - A block to be called for each value selected by this process.
  #<br>Block Arguments
  #* current - An array with one element per dimension with the fully qualified 
  #  index of the element being accessed. 
  #* posn - The position of the element being accessed in the data array.
  def process_all(&block)
    current = Array.new(@dimensions, 0)
    process_all_worker(0, 0, current, &block)
  end
  
  #The worker bee for process_all.
  #<br>Parameters
  #* depth - The index of the dimension being processed.
  #* posn - The partially computed position of the element being accessed 
  #  in the data array.
  #* current - The partial fully qualified index of the element being accessed.
  #* block - A block to be called for each value selected by this process.
  #<br>Block Arguments
  #* current - An array with one element per dimension with the fully qualified 
  #  index of the element being accessed. 
  #* posn - The position of the element being accessed in the data array.
  #<br>Note
  #This is a recursive function. The recursion runs for index in 0..#dimensions
  def process_all_worker(depth, posn, current, &block)
    if depth == @dimensions
      block.call(current, posn)
    else
      spec   = @array_specs[depth]
      stride = spec.stride
    
      spec.each do |index|
        current[depth] = index
        process_all_worker(depth+1, posn, current, &block)
        posn += stride
      end
    end
  end
end