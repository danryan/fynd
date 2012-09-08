require 'forwardable'

require 'fynd/actions'
require 'fynd/operators'
require 'fynd/tests'
require 'fynd/helpers'

module Fynd
  class Sieve
    include Helpers
    include Actions
    include Operators
    include Tests
        
    attr_accessor :collection, :conditions, :files
    
    def initialize
      @collection = []
      @conditions = {}
      @files = nil
    end

    def run
      @files = collection.dup
      # first we match files with our tests 
      conditions['tests'].each do |symbol, value|
        value.nil? ? self.__send__(symbol) : self.__send__(symbol, value)
      end
      
      @files
    end
    
  end
end
