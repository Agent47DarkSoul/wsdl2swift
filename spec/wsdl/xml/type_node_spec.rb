module WSDL
  module XML
    RSpec.describe TypeNode do
      let(:wsdl_content) do
        '<schema targetNamespace="http://excursion.ws.com/Excursion/" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
          <complexType name="AuthenticationRealm">
           <sequence>
            <element name="SourceID" nillable="true" type="xsd:string"/>
            <element name="MessageID" nillable="true" type="xsd:string"/>
            <element name="MessageType" nillable="true" type="xsd:string"/>
            <element name="TimeStamp" nillable="true" type="xsd:string"/>
           </sequence>
          </complexType>
        </schema>'
      end

      let(:xml_node) do
        Nokogiri::XML(wsdl_content).xpath('//xsd:schema//xsd:complexType').first
      end

      subject(:node) { described_class.new(xml_node, 'xsd') }

      context 'when xml node is not "complexType"' do
        let(:xml_node) { Nokogiri::XML::Document.parse('<element></element>') }

        it 'raises ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      describe '#name' do
        subject { node.name }

        context 'when xml node has name attribute' do
          it 'returns name of xml node' do
            expect(subject).to eq('AuthenticationRealm')
          end
        end

        context 'when xml node does not have name' do
          let(:wsdl_content) do
            '<schema targetNamespace="http://excursion.ws.com/Excursion/" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
              <element name="AuthenticateOperationResponse">
                <complexType>
                </complexType>
              </element>
            </schema>'
          end

          it 'returns name of xml parent node' do
            expect(subject).to eq('AuthenticateOperationResponse')
          end
        end
      end

      describe '#property_nodes' do
        subject { node.property_nodes }

        it 'returns property nodes for xml node' do
          expect(subject.count).to eq(4)
        end
      end
    end
  end
end
