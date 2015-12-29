require_relative 'property_builder'

module WSDL
  class Type < Struct.new(:name, :properties); end

  class TypeBuilder
    def initialize(node)
      raise ArgumentError, 'Invalid node' unless node.name == 'complexType'

      @node = node
    end

    def build
      Type.new(@node.attribute('name').value, attribute_nodes)
    end

    def attribute_nodes
      nodes = @node.xpath('xsd:sequence/xsd:element')
      nodes.map { |node| PropertyBuilder.new(node).build }
    end
  end
end
