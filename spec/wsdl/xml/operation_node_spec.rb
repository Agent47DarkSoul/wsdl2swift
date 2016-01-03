module WSDL
  module XML
    RSpec.describe OperationNode do
      let(:wsdl_content) do
        %Q(
        <wsdl:definitions targetNamespace="http://excursion.ws.com/Excursion/" xmlns:apachesoap="http://xml.apache.org/xml-soap" xmlns:impl="http://excursion.ws.com/Excursion/" xmlns:intf="http://excursion.ws.com/Excursion/" xmlns:wsdl="http://schemas.xmlsoap.org/wsdl/" xmlns:wsdlsoap="http://schemas.xmlsoap.org/wsdl/soap/" xmlns:xsdns="http://www.w3.org/2001/XMLSchema">
          <wsdl:operation name="AuthenticateOperationPORT">
            <wsdlsoap:operation soapAction="AuthenticatOperation"/>
            <wsdl:input name="AuthenticateOperationPORTRequest">
              <wsdlsoap:body use="literal"/>
            </wsdl:input>
            <wsdl:output name="AuthenticateOperationPORTResponse">
              <wsdlsoap:body use="encoded"/>
            </wsdl:output>
          </wsdl:operation>
        </wsdl:definitions>
        )
      end

      let(:xml_node) { Nokogiri::XML(wsdl_content).xpath('//wsdl:operation').first }
      subject(:node) { described_class.new(xml_node) }

      context 'when node is not wsdl operation' do
        let(:xml_node) { Nokogiri::XML('<element></element>') }

        it 'raises ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      describe '#name' do
        subject { node.name }

        it 'returns value of name attribute' do
          expect(subject).to eq('AuthenticateOperationPORT')
        end
      end

      describe '#soap_action' do
        subject { node.soap_action }

        it 'returns action endpoint for operation' do
          expect(subject).to eq('AuthenticatOperation')
        end
      end

      describe '#input' do
        subject { node.input }

        it 'returns input request specification' do
          expect(subject.message_name).to eq('AuthenticateOperationPORTRequest')
          expect(subject).to be_literal
        end
      end

      describe '#output' do
        subject { node.output }

        it 'returns output request specification' do
          expect(subject.message_name).to eq('AuthenticateOperationPORTResponse')
          expect(subject).to be_encoded
        end
      end
    end
  end
end