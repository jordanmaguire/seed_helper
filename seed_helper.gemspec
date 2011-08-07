# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "seed_helper/version"

Gem::Specification.new do |s|
  s.name        = "seed_helper"
  s.version     = SeedHelper::VERSION
  s.authors     = ["Jordan Maguire"]
  s.email       = ["jordan@thefrontiergroup.com.au"]
  s.homepage    = "https://github.com/jordanmaguire/seed_helper"
  s.summary     = "Make seeding data easier in Rails projects"
  s.description = "Make seeding data easier in Rails projects"
  s.licenses    = ['WTFPL']

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'colored'
end
