require_relative 'type_node'

module WSDL
  module XML
    class Document
      def initialize(xml_doc)
        @node = xml_doc
      end

      def type_nodes
        @node.xpath(complex_type_path).map do |node|
          TypeNode.new(node, xml_schema_prefix)
        end
      end

      private

      def xml_schema_prefix
        @prefix ||= @node.namespaces.key('http://www.w3.org/2001/XMLSchema').split(':').last
      end

      def complex_type_path
        "//wsdl:types/#{xml_schema_prefix}:schema//#{xml_schema_prefix}:complexType"
      end
    end
  end
end
