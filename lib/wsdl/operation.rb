module WSDL
  class Operation < Struct.new(:name, :soap_action, :request_message, :response_message); end
end