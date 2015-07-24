$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "peephole/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "peephole"
  s.version     = Peephole::VERSION
  s.authors     = ["tnantoka"]
  s.email       = ["tnantoka@bornneet.com"]
  s.homepage    = "https://github.com/tnantoka/peephole"
  s.summary     = "Log viewer for Rails" 
  s.description = "Peephole is a Rails engine that provides interface to view logs."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.2"

  s.add_development_dependency "sqlite3", "~> 1.3"
  s.add_development_dependency "rspec-rails", "~> 3.3"
  s.add_development_dependency "simplecov", "~> 0.10"
end
