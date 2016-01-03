module SOAP
  class Request
    def initialize(operation, types)
      @operation = operation
      @types = types
    end

    def to_xml
      generate_message_xml(@operation.request_message).to_xml
    end

    private

    def tag_name(prefix, name)
      [prefix, name].compact.join(':')
    end

    def generate_message_xml(message)
      envelope = Nokogiri::XML::Element.new(tag_name('soapenv', 'Envelope'), document)
      envelope.add_namespace_definition('soapenv', "http://schemas.xmlsoap.org/soap/envelope/")
      envelope.add_namespace_definition('exc', "http://excursion.ws.com/Excursion/")

      header = Nokogiri::XML::Element.new(tag_name('soapenv', 'Header'), document)
      body = Nokogiri::XML::Element.new(tag_name('soapenv', 'Body'), document)


      body << generate_type_xml(message.implementation, 'exc')

      envelope << header
      envelope << body

      document << envelope

      document
    end

    def generate_type_xml(type, prefix = nil)
      node = Nokogiri::XML::Element.new(tag_name(prefix, type.name), document)
      generate_properties_xml_for_type(type.properties, prefix, node)
    end

    def generate_properties_xml_for_type(properties, prefix, node)
      properties.each_with_object(node) do |property, type_node|
        type_node << generate_property_xml(property, prefix)
      end
    end

    def generate_property_xml(property, prefix)
      node = Nokogiri::XML::Element.new(tag_name(prefix, property.name), document)

      unless property.inbuilt_type?
        type = @types.detect { |type| type.name == property.type }
        generate_properties_xml_for_type(type.properties, prefix, node)
      end

      node
    end

    def document
      @document ||= Nokogiri::XML::Document.new
    end
  end
end
