$:.push File.expand_path("../lib", __FILE__)

require "jasperserver-rails/version"

Gem::Specification.new do |s|
  s.name        = "jasperserver-rails"
  s.version     = JasperserverRails::VERSION
  s.authors     = ["Chris McKnight"]
  s.email       = ["cmckni3@gmail.com"]
  s.homepage    = "http://github.com/cmckni3/jasperserver-rails"
  s.summary     = "Download reports in various formats from jasperserver"
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md", "CHANGELOG.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 3.2'
  s.add_dependency 'rest-client', '~> 2.0.2'
end
