module WSDL
  RSpec.describe File do
    let(:file_path) { Wsdl2swift.root + 'spec/support/data/wsdl_sample_types.xml' }
    subject(:file) { described_class.new(file_path) }

    describe '#types' do
      subject(:types) { file.types }

      it 'returns all types' do
        type_names = types.map(&:name)
        expect(type_names).to match_array([
          'AuthenticationRealm', 'AuthenticateOperationBody', 'OperationRealm',
          'OperationError', 'AuthenticateOperationResponse', 'AuthenticateOperation'])
      end

      it 'returns properties for types' do
        type = types.detect { |type| type.name == 'AuthenticationRealm' }

        expect(type.properties.map(&:name)).to match_array(['SourceID', 'MessageID', 'MessageType', 'TimeStamp'])
      end
    end

    describe '#messages' do
      subject(:messages) { file.messages }

      it 'returns all messages' do
        message_names = messages.map(&:name)
        expect(message_names).to match_array([
          'AuthenticateOperationPORTRequest', 'AuthenticateOperationPORTResponse'])
      end

      it 'returns implementation for messages' do
        message = messages.detect { |message| message.name == 'AuthenticateOperationPORTRequest' }

        expect(message.implementation.name).to eq('AuthenticateOperation')
      end
    end

    describe '#operations' do
      subject(:operations) { file.operations }

      it 'returns all operations' do
        operation_names = operations.map(&:name)
        expect(operation_names).to match_array(['AuthenticateOperationPORT'])
      end

      it 'returns operations with request message' do
        operation = operations.detect { |o| o.name == 'AuthenticateOperationPORT' }

        expect(operation.request_message.name).to eq('AuthenticateOperationPORTRequest')
      end

      it 'returns operations with response message' do
        operation = operations.detect { |o| o.name == 'AuthenticateOperationPORT' }

        expect(operation.response_message.name).to eq('AuthenticateOperationPORTResponse')
      end
    end
  end
end
