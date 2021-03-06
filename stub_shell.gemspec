# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stub_shell/version"

Gem::Specification.new do |s|
  s.name        = "stub_shell"
  s.version     = StubShell::VERSION
  s.authors     = ["Justin Leitgeb", "itsmeduncan"]
  s.email       = ["justin@stackbuilders.com", "itsmeduncan@gmail.com"]
  s.homepage    = "http://github.com/stackbuilders/stub_shell"
  s.summary     = %q{Stub results of shell commands for test purposes}
  s.description = %q{Stubs a set of shell commands and their return values using the backquote operator.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rake', '~> 0.9.2.2'
  s.add_development_dependency 'rspec', '~> 2.8.0'
  s.add_development_dependency 'simplecov', '~> 0.5.4'
end
