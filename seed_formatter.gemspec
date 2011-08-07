# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "seed_formatter/version"

Gem::Specification.new do |s|
  s.name        = "seed_formatter"
  s.version     = SeedFormatter::VERSION
  s.authors     = ["Jordan Maguire"]
  s.email       = ["jmaguire@thefrontiergroup.com.au"]
  s.homepage    = ""
  s.summary     = "summary"
  s.description = "desc"

  s.rubyforge_project = "seed_formatter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency 'colored'
end
