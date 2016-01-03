require_relative '../message'

module WSDL
  module Builders
    class MessageBuilder
      private_class_method :new

      def initialize(message_node)
        @node = message_node
      end

      def build(type_nodes)
        Message.new(@node.name, type_from(type_nodes))
      end

      def self.build(message_node, type_nodes)
        new(message_node).build(type_nodes)
      end

      private

      def type_from(nodes)
        type_node = nodes.detect { |node| node.name == @node.implementation_name }

        raise "Implementation not found: #{@node.implementation_name}" unless type_node

        TypeBuilder.build(type_node)
      end
    end
  end
end
