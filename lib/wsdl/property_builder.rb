module WSDL
  class Property < Struct.new(:type, :name, :optional);
    include Inflections

    def tokenized_type
      classify(type)
    end
  end

  class PropertyBuilder
    def initialize(node)
      raise ArgumentError, 'Invalid node' unless node.name == 'element'

      @node = node
    end

    def build
      Property.new(node_type, node_name, node_optional?)
    end

    private

    def node_type
      @node.attribute('type').value.split(':').last
    end

    def node_name
      @node.attribute('name').value
    end

    def node_optional?
      attribute = @node.attribute('nillable')
      attribute && eval(attribute.value)
    end
  end
end
