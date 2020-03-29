require_relative '../lib/flex_array'
gem              'minitest'
require          'minitest/autorun'

class SpecArrayTester < Minitest::Test

  def test_that_it_builds_specs
    spec = SpecArray.new([0...10, 0...8])
    assert(2, spec.spec_dimensions)
    assert(0...10, spec[0].range)
    assert(8, spec[0].stride)
    assert(0...8, spec[1].range)
    assert(1, spec[1].stride)
    assert(80, spec.spec_count)
  end
end
