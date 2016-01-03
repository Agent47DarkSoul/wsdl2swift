module WSDL
  module XML
    class OperationNode
      def initialize(xml_node)
        raise ArgumentError, "Invalid node: #{xml_node.name}" unless xml_node.name == 'operation'

        @node = xml_node
      end

      def name
        @node['name']
      end

      def soap_action
        @node.xpath("#{soap_prefix}:operation").first['soapAction']
      end

      def input
        DataSpecification.new(@node.xpath("#{prefix}:input").first, soap_prefix)
      end

      def output
        DataSpecification.new(@node.xpath("#{prefix}:output").first, soap_prefix)
      end

      private

      def soap_prefix
        @node.namespaces.key('http://schemas.xmlsoap.org/wsdl/soap/').split(':').last
      end

      def prefix
        @node.namespace.prefix
      end

      class DataSpecification
        def initialize(spec_node, wsdl_soap_prefix)
          @node = spec_node
          @prefix = wsdl_soap_prefix
        end

        def message_name
          @node['name']
        end

        def literal?
          use_attribute == 'literal'
        end

        def encoded?
          use_attribute == 'encoded'
        end

        private

        def use_attribute
          @node.xpath("#{@prefix}:body").first['use']
        end
      end
    end
  end
end