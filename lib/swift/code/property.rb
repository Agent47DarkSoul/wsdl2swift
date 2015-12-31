module Swift
  module Code
    class Property
      include WSDL::Inflections

      def initialize(property)
        @property = property
      end

      def name
        camelize(@property.name)
      end

      def type
        "#{classify(@property.type)}#{optional_symbol}"
      end

      def optional?
        @property.optional?
      end

      def xml_name
        @property.name
      end

      private

      def optional_symbol
        @property.optional? ? '?' : ''
      end
    end
  end
end