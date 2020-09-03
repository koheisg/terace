$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "fishur/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "fishur"
  spec.version     = Fishur::VERSION
  spec.authors     = ["Kohei SUGI"]
  spec.email       = ["kohei.sg@gmail.com"]
  spec.homepage    = "https://github.com/koheisg/terace"
  spec.summary     = "Rss Feed Renderer."
  spec.description = "Rss Feed Renderer for Ruby on Rails"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.2"

  spec.add_development_dependency "pg"
end
