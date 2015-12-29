require 'open-uri'
require 'nokogiri'

module WSDL
  class File
    def initialize(path)
      @xml = Nokogiri::XML(open(path))
    end

    def types
      complex_type_nodes = @xml.xpath("//wsdl:types/xsd:schema/xsd:complexType")

      complex_type_nodes.map do |node|
        TypeBuilder.new(node).build
      end
    end
  end

  class Type < Struct.new(:name, :properties); end
  class Property < Struct.new(:type, :name, :optional); end

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
      @node.attribute('type').value
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
