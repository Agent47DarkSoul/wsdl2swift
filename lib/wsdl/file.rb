require 'open-uri'
require 'nokogiri'

require_relative 'type_builder'

module WSDL
  class File
    def initialize(path)
      @doc = Nokogiri::XML(open(path))
    end

    def types
      Document.new(@doc).complex_types.map do |node|
        TypeBuilder.new(node).build
      end
    end
  end

  class Node
    attr_reader :xml_node, :prefix

    def initialize(node, prefix = nil)
      @xml_node = node
      @prefix = prefix
    end

    def complex_type?
      xml_node.name == 'complexType'
    end

    def property_node?
      xml_node.name == 'element'
    end
  end

  class Document < Node
    def complex_types
      xml_node.xpath(complex_type_path).map do |node|
        ComplexType.new(node, xml_schema_prefix)
      end
    end

    private

    def xml_schema_prefix
      @prefix ||= xml_node.namespaces.key('http://www.w3.org/2001/XMLSchema').split(':').last
    end

    def complex_type_path
      "//wsdl:types/#{xml_schema_prefix}:schema//#{xml_schema_prefix}:complexType"
    end
  end

  class ComplexType < Node
    def name
      attribute = xml_node.attribute('name') || xml_node.parent.attribute('name')
      attribute.value
    end

    def property_nodes
      nodes = xml_node.xpath(property_node_path)
      nodes.map { |node| PropertyNode.new(node) }
    end

    private

    def property_node_path
      "#{prefix}:sequence/#{prefix}:element"
    end
  end

  class PropertyNode < Node
    def max_occurance
      attribute = xml_node.attribute('maxOccurs')
      attribute && attribute.value
    end

    def name
      xml_node.attribute('name').value
    end

    def nillable
      attribute = xml_node.attribute('nillable')
      attribute && attribute.value
    end

    def type
      xml_node.attribute('type').value.split(':').last
    end
  end
end
