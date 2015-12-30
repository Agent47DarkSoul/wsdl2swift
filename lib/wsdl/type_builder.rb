require_relative 'type'
require_relative 'property_builder'

module WSDL
  class TypeBuilder
    private_class_method :new

    def self.build(node)
      new(node).build
    end

    def initialize(node)
      @node = node
    end

    def build
      Type.new(@node.name, node_properties)
    end

    private

    def node_properties
      @node.property_nodes.map { |node| PropertyBuilder.build(node) }
    end
  end
end
