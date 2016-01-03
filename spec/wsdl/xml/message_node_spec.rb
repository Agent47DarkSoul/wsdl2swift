module WSDL
  module XML
    RSpec.describe MessageNode do
      let(:wsdl_content) do
        %Q(
        <?xml version="1.0" encoding="UTF-8"?>
        <wsdl:definitions targetNamespace="http://excursion.ws.com/Excursion/" xmlns:apachesoap="http://xml.apache.org/xml-soap" xmlns:impl="http://excursion.ws.com/Excursion/" xmlns:intf="http://excursion.ws.com/Excursion/" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:wsdlsoap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsdns="http://www.w3.org/2001/XMLSchema">
          <wsdl:message name="AuthenticateOperationPORTRequest">
            <wsdl:part element="impl:AuthenticateOperation" name="AuthenticateOperation"></wsdl:part>
          </wsdl:message>
        </wsdl:definitions>
        )
      end

      let(:xml_node) { Nokogiri::XML(wsdl_content).xpath('//wsdl:message').first }
      subject(:node) { described_class.new(xml_node, 'wsdl') }

      context 'when xml node is not message' do
        let(:xml_node) { Nokogiri::XML('<element></element>') }

        it 'raises ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      describe '#name' do
        subject { node.name }

        it 'returns value of name attribute' do
          expect(subject).to eq('AuthenticateOperationPORTRequest')
        end
      end

      describe '#implementation_name' do
        subject { node.implementation_name }

        it 'returns name of the implementation type' do
          expect(subject).to eq('AuthenticateOperation')
        end
      end
    end
  end
end
