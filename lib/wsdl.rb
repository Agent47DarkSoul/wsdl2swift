module WSDL
  module Inflections
    def classify(string)
      "#{string[0].upcase}#{string[1..-1]}"
    end
  end
end
