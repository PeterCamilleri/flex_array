# This helper class encapsulates an array of flex array spec components.

class SpecArray < Array
  #The number of elements defined by this array specification.
  attr_reader :spec_count

  #The number of dimensions specified by this specification
  alias spec_dimensions length

  # Create a flex array specification.
  def initialize(array_specs)
    super(0)
    @spec_count = 1

    #Parse the array limits.
    array_specs.reverse_each do |spec|
      self.insert(0, spec.to_spec_component(@spec_count))
      @spec_count *= self[0].span
    end

    self
  end

  # Is this array specification transposed in any way?
  def transposed?
    check = 1

    self.reverse_each do |component|
      return true unless check == component.stride
      check *= component.span
    end

    false
  end

  # Enlarge the flex array along its first dimension.
  def enlarge(growth)
    self[0].enlarge(growth)

    #Compute the new size.
    @spec_count = self.inject(1) {|product, element| product*element.span}
  end
end
