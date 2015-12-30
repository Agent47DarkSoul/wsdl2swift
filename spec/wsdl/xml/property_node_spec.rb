module WSDL
  module XML
    RSpec.describe PropertyNode do
      let(:content) { '<element name="SourceID" maxOccurs="unbounded" minOccurs="0" nillable="true" type="xsd:string"/>' }
      let(:xml_node) { Nokogiri::XML(content).children.first }

      subject(:node) { described_class.new(xml_node) }

      context 'when xml node is not of "element" type' do
        let(:xml_node) { Nokogiri::XML('<incorrect_type></incorrect_type>') }

        it 'raises ArgumentError' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      describe '#name' do
        subject { node.name }

        it 'returns name attribute value' do
          expect(subject).to eq('SourceID')
        end
      end

      describe '#type' do
        subject { node.type }

        it 'returns type without namespace prefix' do
          expect(subject).to eq('string')
        end
      end

      describe '#nillable' do
        subject { node.nillable }

        it 'returns nillable attribute value' do
          expect(subject).to eq('true')
        end
      end

      describe '#max_occurance' do
        subject { node.max_occurance }

        it 'returns maxOccurs attribute value' do
          expect(subject).to eq('unbounded')
        end
      end
    end
  end
end
