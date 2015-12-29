module WSDL
  RSpec.describe File do
    subject(:file) { described_class.new(file_path) }

    describe '#types' do
      let(:file_path) { Wsdl2swift.root + '/spec/support/data/wsdl_sample_types.xml' }

      subject(:types) { file.types }

      it 'returns all types' do
        type_names = types.map(&:name)
        expect(type_names).to match_array([
          'AuthenticationRealm', 'AuthenticateOperationBody', 'OperationRealm',
          'OperationError', 'AuthenticateOperationResponseBody'])
      end

      it 'returns properties for types' do
        type = types.detect { |type| type.name == 'AuthenticationRealm' }

        expect(type.properties.map(&:name)).to match_array(['SourceID', 'MessageID', 'MessageType', 'TimeStamp'])
      end
    end
  end
end
