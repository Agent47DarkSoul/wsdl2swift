require_relative 'property'

module WSDL
  class PropertyBuilder
    def initialize(node)
      raise ArgumentError, 'Invalid node' unless node.name == 'element'

      @node = node
    end

    def build
      Property.new(node_type, node_name, node_nillable)
    end

    private

    def node_type
      @node.attribute('type').value.split(':').last
    end

    def node_name
      @node.attribute('name').value
    end

    def node_nillable
      attribute = @node.attribute('nillable')
      attribute && attribute.value
    end
  end
end
