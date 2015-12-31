require 'simplecov'
SimpleCov.command_name 'features'
SimpleCov.coverage_dir 'coverage'

require 'wsdl2swift'
require 'aruba/cucumber'

Dir["#{File.dirname(__FILE__)}/*.rb"].each { |f| require f }
