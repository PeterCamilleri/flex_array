require 'in_array'
require_relative 'spec_component'

#This helper class encapsulates an array of flex array spec components.
class SpecArray < Array
  #The number of elements defined by this array specification.
  attr_reader :spec_count

  The number of dimensions specified by this specification
  alias spec_dimensions length

  #Create a flex array specification.
  #<br>Parameters
  #* array_specs - The specification of the flex array subscript limits.
  #  These can either be an array of containing integers, in which case
  #  the limits are 0...n or they can be ranges, in which case the
  #  limits are those of the range.
  def initialize(array_specs)
    super(0)

    @spec_count = 1

    #Parse the array limits.
    array_specs.reverse_each do |spec|
      self.insert(0, spec.to_spec_component(@count))
      @spec_count *= self[0].span
    end

    self
  end


end
