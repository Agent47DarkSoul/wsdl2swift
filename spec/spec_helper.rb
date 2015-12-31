require 'simplecov'
SimpleCov.command_name 'rspec'
SimpleCov.coverage_dir 'coverage'

require 'wsdl2swift'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = 'random'

  config.alias_it_should_behave_like_to :it_has_behavior, 'has behavior:'
end
