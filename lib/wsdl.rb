module WSDL
  module Inflections
    def classify(string)
      "#{string[0].upcase}#{string[1..-1]}"
    end

    def camelize(string)
      "#{string[0].downcase}#{string[1..-1]}"
    end
  end
end
