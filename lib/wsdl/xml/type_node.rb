require_relative 'property_node'

module WSDL
  module XML
    class TypeNode
      def initialize(xml_node, prefix)
        raise ArgumentError, 'Invalid type node' unless xml_node.name == 'complexType'

        @node = xml_node
        @prefix = prefix
      end

      def name
        name_attribute.value
      end

      def property_nodes
        @node.xpath(property_node_path).map { |node| PropertyNode.new(node) }
      end

      private

      def name_attribute
        @node.attribute('name') || @node.parent.attribute('name')
      end

      def property_node_path
        "#{@prefix}:sequence/#{@prefix}:element"
      end
    end
  end
end
