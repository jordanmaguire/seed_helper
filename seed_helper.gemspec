# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "seed_helper"
  s.version     = "1.2.0"
  s.authors     = ["Jordan Maguire"]
  s.email       = ["jordan@thefrontiergroup.com.au"]
  s.homepage    = "https://github.com/jordanmaguire/seed_helper"
  s.summary     = "Make seeding data easier in Rails projects"
  s.description = <<-EOF
    Use SeedHelper to create rake tasks to be used in your Seeds file.

    Use the output formatters to provide feedback on the results of your Seeds process.
  EOF
  s.licenses    = ['WTFPL']

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'colored', '1.2'
  s.add_dependency 'rake', '>= 10.0.0'
end
