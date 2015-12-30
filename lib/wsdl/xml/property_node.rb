module WSDL
  module XML
    class PropertyNode
      def initialize(node)
        raise ArgumentError, 'Invalid node' unless node.name == 'element'

        @node = node
      end

      def max_occurance
        attribute = @node.attribute('maxOccurs')
        attribute && attribute.value
      end

      def name
        @node.attribute('name').value
      end

      def nillable
        attribute = @node.attribute('nillable')
        attribute && attribute.value
      end

      def type
        @node.attribute('type').value.split(':').last
      end
    end
  end
end