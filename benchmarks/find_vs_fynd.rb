#!/usr/bin/env ruby

$: << File.dirname(__FILE__) + '/../lib' unless $:.include?(File.dirname(__FILE__) + '/../lib/')

require 'fynd'

Benchmark.bm do |x|
  x.report(:find) do 
    %x[ find ~/Code/ext -type f|wc -l ]
  end
  x.report(:fynd) do 
    Fynd.find('~/Code/ext').type(:f).files.count
  end
end