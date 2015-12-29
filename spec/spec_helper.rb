require 'simplecov'
SimpleCov.start do
  add_filter 'vendor/'
  add_filter 'spec/'
end

require 'wsdl2swift'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = 'random'

  config.alias_it_should_behave_like_to :it_has_behavior, 'has behavior:'
end
