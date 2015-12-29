$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "wsdl/version"

Gem::Specification.new do |s|
  s.name        = "wsdl2swift"
  s.version     = WSDL::VERSION
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['MIT']
  s.authors     = ["Danish Satkut"]
  s.email       = ["danish.satkut@infibeam.net"]
  s.homepage    = "https://rubygems.org/gems/wsdl2swift"
  s.summary     = 'Generates swift classes from wsdl file'
  s.description = 'Auto generates swift classes from wsdl file'

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency('commander', '~> 4.3')
  s.add_dependency('nokogiri', '~> 1.6', '>= 1.6.7.1')

  s.add_development_dependency('cucumber', '~> 2.1')
  s.add_development_dependency('pry', '~> 0.10')
  s.add_development_dependency('rspec',     '~> 3.4')
  s.add_development_dependency('simplecov', '~> 0.11')
  s.add_development_dependency('yard', '~> 0.8.7')

  s.post_install_message = "Currently only supports generating swift classes."

  s.files         = Dir["lib/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files    = Dir["spec/**/*"]
  s.require_paths = ["lib"]
end
