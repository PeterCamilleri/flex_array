# coding: utf-8

#Specify the building of the flex_array gem.

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flex_array/version'

Gem::Specification.new do |s|
  s.name = "flex_array"
  s.summary = "A flexible array class."
  s.description = 'A flexible, multidimensional array class for Ruby. '
  s.version = FlexArray::VERSION
  s.author = ["Peter Camilleri"]
  s.email = "peter.c.camilleri@gmail.com"
  s.homepage = "http://teuthida-technologies.com/"
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>=1.9.3'

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency 'rake'
  s.add_development_dependency 'reek', "~> 1.3.8"
  s.add_development_dependency 'minitest', "~> 4.7.5"
  s.add_development_dependency 'minitest_visible', ">= 0.1.0"

  s.add_runtime_dependency 'in_array'

  s.files       = `git ls-files`.split($/).select {|f| f !~ /^docs\//}
  s.test_files  = s.files.grep(%r{^(test)/})

  s.license = 'MIT'
  s.require_paths = ["lib"]
end

