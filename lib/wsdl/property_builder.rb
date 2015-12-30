require_relative 'property'

module WSDL
  class PropertyBuilder
    def initialize(node)
      raise ArgumentError, 'Invalid node' unless node.property_node?

      @node = node
    end

    def build
      Property.new(@node.type, @node.name, @node.nillable, @node.max_occurance)
    end    
  end
end
