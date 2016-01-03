require_relative 'request'

module SOAP
  class XMLGenerator
    def initialize(wsdl_file)
      @file = wsdl_file
    end

    # This methods are not of much use
    def generate_request(operation_name)
      wsdl_operation = @file.operations.detect { |op| op.name == operation_name }

      Request.new(wsdl_operation, @file.types)
    end
  end
end
