require_relative 'type'
require_relative 'property_builder'

module WSDL
  class TypeBuilder
    def initialize(node)
      @node = node
    end

    def build
      Type.new(@node.name, node_properties)
    end

    def node_properties
      @node.property_nodes.map { |node| PropertyBuilder.new(node).build }
    end
  end
end
