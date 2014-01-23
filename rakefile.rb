#!/usr/bin/env rake
require 'rake/testtask'
require 'rdoc/task'

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.rdoc_files = ["lib/flex_array.rb", 
                     "lib/flex_array/flex_array_new.rb",
                     "lib/flex_array/flex_array_index.rb",
                     "lib/flex_array/flex_array_each.rb",
                     "lib/flex_array/flex_array_reshape.rb",
                     "lib/flex_array/flex_array_append.rb",
                     "lib/flex_array/flex_array_transpose.rb",
                     "lib/flex_array/flex_array_process.rb",
                     "lib/flex_array/flex_array_validate.rb",
                     "lib/flex_array/object.rb",
                     "lib/flex_array/integer.rb",
                     "lib/flex_array/range.rb",
                     "lib/flex_array/array.rb",
                     "lib/flex_array/spec_component.rb",
                     "license.txt", "README.txt"]
  rdoc.options << '--visibility' << 'private'
end

Rake::TestTask.new do |t|
  t.test_files = ["tests/spec_component_test.rb",
                  "tests/object_test.rb",
                  "tests/integer_test.rb",
                  "tests/range_test.rb",
                  "tests/array_test.rb",
                  "tests/flex_array_new_test.rb",
                  "tests/flex_array_index_test.rb",
                  "tests/flex_array_each_test.rb",
                  "tests/flex_array_reshape_test.rb",
                  "tests/flex_array_append_test.rb",
                  "tests/flex_array_transpose_test.rb",
                  "tests/flex_array_validate_test.rb",
                  "tests/flex_array_test.rb"]
  t.verbose = false
end

task :reek do |t|
  `reek lib > reek.txt`
end
