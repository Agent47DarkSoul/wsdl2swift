require 'open-uri'
require 'nokogiri'

require_relative 'type_builder'

module WSDL
  class File
    def initialize(path)
      @xml = Nokogiri::XML(open(path))
    end

    def types
      complex_type_nodes = @xml.xpath("//wsdl:types/xsd:schema//xsd:complexType")

      complex_type_nodes.map do |node|
        TypeBuilder.new(node).build
      end
    end
  end
end
