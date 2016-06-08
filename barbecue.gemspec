$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "barbecue/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "barbecue"
  s.version     = Barbecue::VERSION
  s.authors     = ["Jakub Hozak"]
  s.email       = ["jakub.hozak@gmail.com"]
  s.homepage    = "http://github/HakubJozak/barbecue"
  s.summary     = "Barbecue"
  s.description = "Rails tools for Ember apps"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "parser"
  s.add_dependency "unparser"

  s.add_dependency "rails", "=> 4.1"
  s.add_dependency "active_model_serializers"
  s.add_dependency "barber"
  # BEWARE: higher versions of ember-rails may break Emblem compilation
  s.add_dependency "ember-rails",'0.16.2'
  s.add_dependency "emblem-rails"

  # TODO: separate to suspenders
  s.add_dependency "traco"
end
