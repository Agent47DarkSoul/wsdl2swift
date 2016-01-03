module WSDL
  module XML
    class MessageNode
      def initialize(xml_node, prefix)
        raise ArgumentError, 'Invalid node' unless xml_node.name == 'message'

        @node = xml_node
        @prefix = prefix
      end

      def name
        @node.attribute('name').value
      end

      def implementation_name
        part.element
      end

      private

      def part
        @part ||= Part.new(@node.xpath("#{@prefix}:part").first)
      end

      class Part < Struct.new(:node)
        def element
          node.attribute('element').value.split(':').last
        end
      end
    end
  end
end