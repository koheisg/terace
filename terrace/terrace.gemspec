$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "terrace/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "terrace"
  s.version     = Terrace::VERSION
  s.authors     = ["Kohei Sugi"]
  s.email       = ["kohei.sg@gmail.com"]
  s.homepage    = "https://dreamin.cc"
  s.summary     = "Terrace is user name space"
  s.description = "Description of Terrace"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails"

  s.add_development_dependency "sqlite3"
end
