require 'deep_merge'

require 'fined/sieve'

# require 'deep_merge/rails_compat'

# require 'fined/actions'
# require 'fined/operators'
# require 'fined/tests'
# 
module Fined
  class Criteria
    # include Actions
    # include Operators
    # include Tests

    attr_accessor :collection, :sieve
    
    def initialize
      @sieve = Sieve.new(self)
    end
    
    def collection
      @collection ||= []
    end

    def find(path)
      @collection = Dir[path]
      # where(:path => path)
      self
    end

    def conditions
      @conditions ||= {}
    end

    def where(args)
      conditions.deep_merge!(args)
      self
    end
    
    def run
      sieve.run
      self
    end
    
    def method_missing(symbol, *args, &block)
      if Fined::VALID_ACTIONS.include?(symbol)
        where({ symbol.to_sym => args })
        self
      else
        super(symbol, *args, &blocks)
      end
    end
    
    # TODO: implement enumerables; all, first, each, etc.
  end
end