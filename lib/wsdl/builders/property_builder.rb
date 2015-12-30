require_relative '../property'

module WSDL
  module Builders
    class PropertyBuilder
      private_class_method :new

      def self.build(node)
        new(node).build
      end

      def initialize(node)
        @node = node
      end

      def build
        Property.new(@node.type, @node.name, @node.nillable, @node.max_occurance)
      end
    end
  end
end
