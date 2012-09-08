require 'forwardable'
require 'find' # <- lol

require 'fynd/sieve'

module Fynd
  class Criteria
    extend Forwardable

    attr_accessor :sieve
    
    def_delegators :@sieve, :collection, :conditions
    
    def initialize(*paths)
      @sieve = Sieve.new
      @sieve.collection = []      
      @sieve.conditions = {}
      @sieve.conditions['actions'] = {}
      @sieve.conditions['operators'] = {}
      @sieve.conditions['tests'] = {}
      
      # For every path...
      paths.each do |path|
        # Pull out all directories
        # dirs = Dir.glob(File.expand_path(path)).select { |f| File.stat(f).directory? }
        # Shove all found files into the collection
        # @sieve.collection << Dir.glob(File.expand_path(path))
        @sieve.collection << Find.find(path).to_a
      end
      
      # Flatten it and strip out non-unique files
      @sieve.collection.flatten!.uniq!
    end

    # def find(*paths)
    #   where(:paths => paths)
    #   self
    # end
    
    def run
      sieve.run
      return sieve.files
    end
    
    def files
      files = sieve.run
      
      if block_given?
        yield files
      else
        return files
      end
    end
    
    def method_missing(symbol, *args, &block)
      if sieve.respond_to?(symbol)
        if ACTIONS.include?(symbol)
          # Only one action per expression
          sieve.conditions['action'] = { symbol.to_s => args[0] }
        elsif OPERATORS.include?(symbol)
          sieve.conditions['operations'].deep_merge!({ symbol.to_s => args[0] })
        elsif TESTS.include?(symbol)
          sieve.conditions['tests'].deep_merge!({ symbol.to_s => args[0] })
        else
          super(symbol, *args, &blocks)
        end
        self
      else
        super(symbol, *args, &blocks)
      end
    end
    
    # TODO: implement enumerables; all, first, each, etc.
  end
end
