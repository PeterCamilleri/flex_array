require 'in_array'
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

#\FlexArray - A flexible array class.
#* flex_array.rb - The root file that gathers up all the flex array parts.
class FlexArray
  include InArrayAlready

  #The version of this class.
  #<br>Returns
  #* A version string; <major>.<minor>.<step>
  def self.version
    '0.3.0'
  end

  #The version of the class of this instance.
  #<br>Returns
  #* A version string; <major>.<minor>.<step>
  def version
    self.class.version
  end

  #The array specifications. An array of spec components.
  attr_accessor :array_specs

  #The underlying array data used by the flex array.
  attr_accessor :array_data

  #The total number of elements in this array.
  def length
    @array_specs.spec_count
  end

  alias size length

  #The number of dimensions in this array.
  def dimensions
    @array_specs.spec_dimensions
  end

  #Is this flex array transposed?
  attr_reader :transposed

  #Get the limits of the subscripts of the flex array.
  def limits
    @array_specs.collect {|spec| spec.range }
  end

  #Return this flex array as a flex array!
  #<br>Returns
  #* A flex array -- self
  def to_flex_array
    self
  end

  #Are these FlexArrays equal?
  #<br>Parameters
  #* other - The object being tested for equality.
  #<br>Returns
  #* true if the flex arrays are equal shape and data.
  def ==(other)
    self.compatible?(other) && @array_data == other.array_data
  end

  #Make FlexArrays comparable.
  #<br>Parameters
  #* other - The object being tested for compariositality.
  #<br>Returns
  #* 1 if self > other
  #* 0 if self = other
  #* -1 if self < other
  def <=>(other)
    @array_data <=> other.array_data
  end

  #Is this flex array empty?
  def empty?
    length == 0
  end
end
