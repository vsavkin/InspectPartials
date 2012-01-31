# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "inspect_partials/version"

Gem::Specification.new do |s|
  s.name        = "inspect_partials"
  s.version     = InspectPartials::VERSION
  s.authors     = ["Victor Savkin"]
  s.email       = ["vic.savkin@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Gem showing partial names}
  s.description = %q{Gem showing partial names}

  s.rubyforge_project = "inspect_partials"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
