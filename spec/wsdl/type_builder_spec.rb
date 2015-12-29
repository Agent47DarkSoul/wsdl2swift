module WSDL
  RSpec.describe TypeBuilder do
    let(:node) do
      Nokogiri::XML::Document.parse(
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
      ).xpath('//xsd:schema/xsd:complexType').first
    end

    subject(:builder) { described_class.new(node) }

    describe '#build' do
      subject { builder.build }

      context 'when node is complexType' do
        it 'creates a new type with correct name' do
          expect(subject.name).to eq('AuthenticationRealm')
        end

        it 'creates a new type with correct number of properties' do
          expect(subject.properties.count).to eq(4)
        end
      end

      context 'when node is not complexType' do
        let(:node) { Nokogiri::XML::Document.parse('<element></element>') }

        it 'raises ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end
    end
  end
end