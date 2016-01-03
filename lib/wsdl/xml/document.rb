require_relative 'type_node'
require_relative 'message_node'

module WSDL
  module XML
    class Document
      def initialize(xml_doc)
        @node = xml_doc
      end

      def type_nodes
        prefix = xml_schema_prefix

        @node.xpath(complex_type_path).map do |node|
          TypeNode.new(node, prefix)
        end
      end

      def message_nodes
        prefix = wsdl_prefix

        @node.xpath(message_path).map do |node|
          MessageNode.new(node, prefix)
        end
      end

      private

      def xml_schema_prefix
        @node.namespaces.key('http://www.w3.org/2001/XMLSchema').split(':').last
      end

      def complex_type_path
        "//#{wsdl_prefix}:types/#{xml_schema_prefix}:schema//#{xml_schema_prefix}:complexType"
      end

      def message_path
        "//#{wsdl_prefix}:message"
      end

      def wsdl_prefix
        @node.namespaces.key('http://schemas.xmlsoap.org/wsdl/').split(':').last
      end
    end
  end
end
