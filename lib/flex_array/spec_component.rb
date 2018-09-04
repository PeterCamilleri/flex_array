# This helper class encapsulates a single component of the flex array spec.

class SpecComponent
  # The range of acceptable values for this limit.
  attr_reader :range

  # The stride of this array dimension. That is, for each step in this
  # dimension, how many steps are required in the low level array?
  attr_reader :stride

  # Create a limits component from its constituent data.
  def initialize(range, stride)
    @range, @stride = range, stride
  end

  # Forward '=== value' to the range.
  def ===(value)
    @range === value
  end

  # Limits are equal if their ranges are equal.
  def ==(other)
    @range == other.range
  end

  # Forward 'min' to the range.
  def min
    @range.min
  end

  # Forward 'max' to the range.
  def max
    @range.max
  end

  # Forward 'each' and the block to the range.
  def each(&block)
    @range.each(&block)
  end

  # Compute the span of indexes in this limit component.
  def span
    if @range.none?
      0
    else
      @range.max - @range.min + 1
    end
  end

  # Enlarge the range of this spec by the growth term.
  def enlarge(growth)
    if @range.none?
      @range = 0...growth
    else
      @range = (@range.min)..(@range.max + growth)
    end
  end

  # Compute the step required for the index value.
  def index_step(index)
    (index - @range.min) * @stride
  end
end
