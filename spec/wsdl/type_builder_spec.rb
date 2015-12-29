module WSDL
  RSpec.describe TypeBuilder do
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

    let(:node) do
      Nokogiri::XML(wsdl_content).xpath('//xsd:schema//xsd:complexType').first
    end

    subject(:builder) { described_class.new(node) }

    describe '#build' do
      subject { builder.build }

      context 'when node is complexType' do
        context 'when complexType has name attribute' do
          it 'creates a new type with correct name' do
            expect(subject.name).to eq('AuthenticationRealm')
          end

          it 'creates a new type with correct number of properties' do
            expect(subject.properties.count).to eq(4)
          end
        end

        context 'when complexType does not have name' do
          let(:wsdl_content) do
            '<schema targetNamespace="http://excursion.ws.com/Excursion/" xmlns="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
              <element name="AuthenticateOperationResponse">
                <complexType>
                  <sequence>
                    <element name="Header" nillable="true" type="impl:OperationRealm"/>
                    <element name="Body" nillable="true" type="impl:AuthenticateOperationResponseBody"/>
                  </sequence>
                </complexType>
              </element>
            </schema>'
          end

          it 'creates Type with parent element node name' do
            expect(subject.name).to eq('AuthenticateOperationResponse')
          end

          it 'creates Type with correct number of properties' do
            expect(subject.properties.count).to eq(2)
          end
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