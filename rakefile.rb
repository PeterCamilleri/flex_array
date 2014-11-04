#!/usr/bin/env rake
# coding: utf-8

require 'rake/testtask'
require 'rdoc/task'
require "bundler/gem_tasks"

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = "rdoc"

  #List out all the files to be documented.
  rdoc.rdoc_files.include("lib/**/*.rb", "license.txt", "readme.txt")

  rdoc.options << '--visibility' << 'private'
end

Rake::TestTask.new do |t|
  #List out all the test files.
  t.test_files = FileList['tests/**/*.rb']
  t.verbose = false
end

desc "Run a scan for smelly code!"
task :reek do |t|
  `reek --no-color lib > reek.txt`
end

def eval_puts(str)
  puts str
  eval str
end

desc "Run an interactive flex array session."
task :console do
  require 'irb'
  require 'irb/completion'
  require_relative 'lib/flex_array'
  eval_puts "@a = FlexArray.new([2,3,4]) {|i| i.clone}"
  eval_puts "@b = FlexArray.new([2,3,4]) {|i| (i[0]+i[2])*(i[1] + i[2])}"
  eval_puts "@c = FlexArray.new([0,3])"
  eval_puts "@d = FlexArray.new([3,3]) {|i| i[0]*3 + i[1]}"
  ARGV.clear
  IRB.start
end

desc "What version of flex_array is this?"
task :vers do |t|
  puts
  puts "flex_array version = #{FlexArray::VERSION}"
end
