# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "seed_formatter/version"

Gem::Specification.new do |s|
  s.name        = "seed_formatter"
  s.version     = SeedFormatter::VERSION
  s.authors     = ["Jordan Maguire"]
  s.email       = ["jmaguire@thefrontiergroup.com.au"]
  s.homepage    = "https://github.com/jordanmaguire/seed_formatter"
  s.summary     = "Easily format the output of your seeds and parse YAML files"
  s.description = "Easily format the output of your seeds and parse YAML files"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'colored'
end
