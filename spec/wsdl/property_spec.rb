module WSDL
  RSpec.describe Property do
    subject(:property) { described_class.new('Type', 'SampleName', nillable) }

    describe '#optional?' do
      subject { property.optional? }

      context 'when nillable is "true"' do
        let(:nillable) { 'true' }

        it('returns true') { expect(subject).to be(true) }
      end

      context 'when nillable is nil' do
        let(:nillable) { nil }

        it('returns false') { expect(subject).to be(false) }
      end
    end

    describe '#tokenized_type' do
      subject { property.tokenized_type }

      it 'returns type in tokenized form of language' do
        expect(subject).to eq('String')
      end
    end
  end
end
