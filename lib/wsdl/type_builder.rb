require_relative 'property_builder'

module WSDL
  class Type < Struct.new(:name, :properties); end

  class TypeBuilder
    def initialize(node)
      raise ArgumentError, 'Invalid node' unless node.name == 'complexType'

      @node = node
    end

    def build
      Type.new(node_name, attribute_nodes)
    end

    private

    def attribute_nodes
      nodes = @node.xpath('xsd:sequence/xsd:element')
      nodes.map { |node| PropertyBuilder.new(node).build }
    end

    def node_name
      attribute = @node.attribute('name') || @node.parent.attribute('name')
      attribute.value
    end
  end
end
