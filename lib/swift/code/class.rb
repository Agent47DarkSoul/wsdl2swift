module Swift
  module Code
    class Class
      include WSDL::Inflections

      def initialize(type)
        @type = type
      end

      def name
        classify(@type.name)
      end

      def properties
        @type.properties.map do |property|
          Property.new(property)
        end
      end

      def bindings
        Kernel.binding
      end
    end
  end
end
