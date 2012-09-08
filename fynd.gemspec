# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fynd/version'

Gem::Specification.new do |gem|
  gem.name          = "fynd"
  gem.version       = Fynd::VERSION
  gem.authors       = ["Dan Ryan"]
  gem.email         = ["scriptfu@gmail.com"]
  gem.description   = %q{A pure Ruby re-implementation of GNU find.}
  gem.summary       = %q{I found GNU find to be slow, so I made it slower by rewriting it in Ruby.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency "activesupport", '~> 3.2.8'
end
