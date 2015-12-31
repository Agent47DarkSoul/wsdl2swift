require 'simplecov'
SimpleCov.start do
  add_filter 'vendor/'
  add_filter 'spec/'
  add_filter 'features/'
end

require 'wsdl2swift'
require 'aruba/cucumber'

Dir["#{File.dirname(__FILE__)}/*.rb"].each { |f| require f }
