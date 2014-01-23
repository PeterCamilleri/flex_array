#Specify the building of the flex_array gem.

Gem::Specification.new do |s|
  s.name = "flex_array"
  s.summary = "A flexible array class."
  s.description = 'A flexible array class. '
  s.version = '0.2.0' 
  s.author = ["Peter Camilleri"]
  s.email = "peter.c.camilleri@gmail.com"
  s.homepage = "http://teuthida-technologies.com/"
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>=1.9.3'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'reek'
  s.add_development_dependency 'minitest'
  s.add_runtime_dependency 'in_array'
  s.files  = ['lib/flex_array.rb'] 
  s.files += Dir['lib/flex_array/*.rb']
  s.files += Dir['tests/*.rb']
  s.files += ['rakefile.rb', 
              'license.txt', 
              'readme.txt', 
              'reek.txt']
  s.extra_rdoc_files = ['license.txt']
  s.test_files = Dir['tests/*.rb']
  s.license = 'MIT'
  s.has_rdoc = true
  s.require_path = 'lib'
end

