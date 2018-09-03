#!/usr/bin/env rake
# coding: utf-8

require 'rake/testtask'
require "bundler/gem_tasks"

Rake::TestTask.new do |t|
  #List out all the test files.
  t.test_files = FileList['tests/**/*.rb']
  t.verbose = false
end

desc "Run a scan for smelly code!"
task :reek do |t|
  `reek --no-color lib > reek.txt`
end

desc "Run an interactive flex array session."
task :console do
  system "ruby irbt.rb local"
end

desc "What version of flex_array is this?"
task :vers do |t|
  puts
  puts "flex_array version = #{FlexArray::VERSION}"
end
