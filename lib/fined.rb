require 'fined/version'
require 'fined/core_ext/deep_merge'

require 'fined/actions'
require 'fined/operators'
require 'fined/tests'

require 'fined/criteria'

module Fined
  VALID_ACTIONS = [ 
    Fined::Actions, 
    Fined::Operators, 
    Fined::Tests 
  ].inject([]) do |result, mod|
    result + mod.instance_methods
  end
  
  def self.find(path)
    Criteria.new.find(path)
  end

end
