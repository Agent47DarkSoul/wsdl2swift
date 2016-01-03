require_relative '../operation'

module WSDL
  module Builders
    class OperationBuilder
      def initialize(operation_node)
        @node = operation_node
      end

      def build(messages)
        Operation.new(
          @node.name, @node.soap_action,
          message_from(messages, @node.input),
          message_from(messages, @node.output))
      end

      def self.build(operation_node, messages)
        new(operation_node).build(messages)
      end

      private

      def message_from(messages, operation_data)
        message = messages.detect { |message| message.name == operation_data.message_name }

        message || raise("Implementation not found: #{operation_data.message_name}")
      end
    end
  end
end
