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
        classify(@property.type)
      end
    end
  end
end