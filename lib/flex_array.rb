require 'in_array'

require_relative 'flex_array/version'

require_relative 'flex_array/flex_array_forever'
require_relative 'flex_array/spec_component'
require_relative 'flex_array/spec_array'
require_relative 'flex_array/object'
require_relative 'flex_array/integer'
require_relative 'flex_array/range'
require_relative 'flex_array/array'

require_relative 'flex_array/flex_array_new'
require_relative 'flex_array/flex_array_index'
require_relative 'flex_array/flex_array_append'
require_relative 'flex_array/flex_array_reshape'
require_relative 'flex_array/flex_array_transpose'
require_relative 'flex_array/flex_array_each'
require_relative 'flex_array/flex_array_validate'
require_relative 'flex_array/flex_array_process'

# A flexible array class.
class FlexArray
  include InArrayAlready

  # The version of this class. "<major>.<minor>.<step>"
  def self.version
    FlexArray::VERSION
  end

  # The version of the class of this instance.
  def version
    FlexArray::VERSION
  end

  # The array specifications. An array of spec components.
  attr_accessor :array_specs

  # The underlying array data used by the flex array.
  attr_accessor :array_data

  # The total number of elements in this array.
  def length
    @array_specs.spec_count
  end

  alias size length

  # The number of dimensions in this array.
  def dimensions
    @array_specs.spec_dimensions
  end

  # Is this flex array transposed?
  attr_reader :transposed

  # Get the limits of the subscripts of the flex array.
  def limits
    @array_specs.collect {|spec| spec.range }
  end

  # Return this flex array as a flex array!
  def to_flex_array
    self
  end

  # Are these FlexArrays equal?
  def ==(other)
    self.compatible?(other) && @array_data == other.array_data
  end

  # Make FlexArrays comparable with the compariositality method.
  def <=>(other)
    @array_data <=> other.array_data
  end

  # Is this flex array empty?
  def empty?
    length == 0
  end
end
