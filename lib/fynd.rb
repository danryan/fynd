require 'active_support/all'

require 'fynd/version'

require 'fynd/actions'
require 'fynd/operators'
require 'fynd/tests'

require 'fynd/criteria'

module Fynd  
  ACTIONS = Fynd::Actions.instance_methods
  OPERATORS = Fynd::Operators.instance_methods
  TESTS = Fynd::Tests.instance_methods
  
  extend self
  
  def find(*paths)
    Criteria.new(*paths)
  end

end
