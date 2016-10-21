$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "scavenger/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "scavenger"
  s.version     = Scavenger::VERSION
  s.authors     = ["Johan Halse"]
  s.email       = ["johan.halse@varvet.com"]
  s.homepage    = "https://www.varvet.com"
  s.summary     = "A sweet SVG icon plugin for Rails"
  s.description = "Scavenger takes a directory full of SVG files and turns them into a usable icon sprite sheet"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2"
  s.add_dependency "nokogiri", "~> 1.6"
  s.add_dependency "capybara", "~> 2.10"

  s.add_development_dependency "pry", "~> 0.10"
end
