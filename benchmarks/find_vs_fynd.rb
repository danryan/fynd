#!/usr/bin/env ruby

$: << File.dirname(__FILE__) + '/../lib' unless $:.include?(File.dirname(__FILE__) + '/../lib/')

require 'fynd'

# Set up a bunch of test directories

require 'fileutils'
include FileUtils

test_dir = "/tmp/fynd_tests"

puts "=> making test dir #{test_dir}"
mkdir_p test_dir

# %w( 5 10 50 100 500 1000 5000 10000 ).each do |count|
%w( 5 10 50 100 500 1000 5000 10000 ).each do |count|
  puts "=> filling #{test_dir}/#{count} with #{count} files"
  mkdir_p "#{test_dir}/#{count}"
  (1..count.to_i).each do |i|
    touch "#{test_dir}/#{count}/#{i}"
  end
  
  Benchmark.bmbm(10) do |x|
    x.report(:find) do 
      puts %x[ find #{test_dir}/#{count} -type f|wc -l ]
    end

    x.report(:fynd) do 
      puts Fynd.find(File.join(test_dir, count)).type(:f).files.count
    end
  end
  
  puts "=> cleaning up test files"
  rm_rf test_dir
  puts
  puts
end
    
# search a directory with a fairly large number of files. (over 100,000)



