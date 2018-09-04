# The flexible array class constructor and related methods.
class FlexArray
  # Construct a flexible array object.
  def initialize(array_specs, default=nil, &init_block)
    @array_specs = SpecArray.new(array_specs.in_array)
    @transposed = false

    # Allocate the data for the array.
    @array_data = Array.new(@array_specs.spec_count, default)

    # Set up the array with the optional init_block.
    if init_block
      process_all {|index, posn| @array_data[posn] = init_block.call(index)}
    end
  end

  alias_method :shallow_dup, :dup

  # Create a duplicate of this array.
  def dup
    other = self.shallow_dup
    other.array_specs = @array_specs.dup
    other.array_data  = @array_data.dup
    other
  end

  # Construct a flex array using other as a template or data source.
  def self.new_from(array_specs, other)
    iterator = other.array_data.cycle
    FlexArray.new(array_specs) {iterator.next}
  end

  # Construct a flex array using a all or a portion of portion of another flex
  # array as a data source.
  def self.new_from_selection(array_specs, other, selection)
    iterator = other.select_cycle(selection)
    FlexArray.new(array_specs) {iterator.next}
  end

  # Construct a flex array as a duplicate of a source array or flex array.
  def self.new_from_array(other)
    result = FlexArray.new(0)
    result.array_specs = other.array_specs.dup
    result.array_data = other.array_data
    result
  end
end