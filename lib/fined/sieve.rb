require 'forwardable'

require 'fined/actions'
require 'fined/operators'
require 'fined/tests'

module Fined
  class Sieve
    include Actions
    include Operators
    include Tests
    extend Forwardable
    
    attr_accessor :criteria
    
    def_delegators :@criteria, :collection, :conditions
    
    def initialize(criteria)
      @criteria = criteria
    end
    
    def run
      conditions.each do |symbol, values|
        values.each do |value|
          self.__send__(symbol, value)
        end
      end
    end
    
  end
end