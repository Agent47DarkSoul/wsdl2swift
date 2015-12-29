module WSDL
  class Property < Struct.new(:type, :name, :nillable);
    include Inflections

    def tokenized_type
      classify(type)
    end

    def optional?
      nillable == 'true'
    end
  end

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
