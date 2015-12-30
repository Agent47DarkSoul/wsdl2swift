require 'open-uri'
require 'nokogiri'

require_relative 'xml/document'
require_relative 'type_builder'

module WSDL
  class File
    def initialize(path)
      @doc = Nokogiri::XML(open(path))
    end

    def types
      XML::Document.new(@doc).type_nodes.map do |node|
        TypeBuilder.build(node)
      end
    end
  end
end
