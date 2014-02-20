#* flex_array_append.rb - The flexible array class << and related methods.
class FlexArray
  #Append to the flex array.
  #<br>Parameters
  #* data - the data being appended to this array.
  #<br>Returns
  #* The array spec of the array being appended.
  #<br>Exceptions
  #* ArgumentError if the data may not be appended.
  def << (data)
    specs = get_append_specs(data = data.in_array)
    @array_data += data.array_data
    @array_specs[0].enlarge(specs[0].span)
    @count += data.count
    self
  end

  #Make a copy of the other's data.
  #<br>Parameters
  #* other - The flex array whose data is to be copied.
  def copy_data(other)
    fail ArgumentError, "Incompatible data copy." unless compatible?(other)
    @array_data = other.array_data.dup
  end

  private
  #Extract and validate the append array_spec
  #<br>Parameters
  #* data - the data being appended to this array.
  #<br>Returns
  #* The array spec of the array being appended.
  #<br>Exceptions
  #* ArgumentError if the data may not be appended.
  def get_append_specs(data)
    spec_len = (specs = data.array_specs).length
    
    if @dimensions == spec_len+1
      specs.insert(0, SpecComponent.new(0...1, nil))
    elsif @dimensions != spec_len
      fail ArgumentError, "Incompatible dimensionality error on <<."
    end
    
    (1...@dimensions).each do |index|
      unless @array_specs[index] == specs[index]
        fail ArgumentError, "Dimension mismatch error on <<."
      end
    end
    
    specs
  end
end