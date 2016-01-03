require 'open-uri'
require 'nokogiri'

require_relative 'xml/document'
require_relative 'builders/type_builder'
require_relative 'builders/message_builder'

module WSDL
  class File
    def initialize(path)
      @path = path
    end

    def types
      xml_document.type_nodes.map do |node|
        Builders::TypeBuilder.build(node)
      end
    end

    def messages
      type_nodes = xml_document.type_nodes

      xml_document.message_nodes.map do |node|
        Builders::MessageBuilder.build(node, type_nodes)
      end
    end

    def message(name)
      messages.detect { |m| m.name == name }
    end

    private

    def document
      @document ||= Nokogiri::XML(open(@path))
    end

    def xml_document
      XML::Document.new(document)
    end
  end
end
