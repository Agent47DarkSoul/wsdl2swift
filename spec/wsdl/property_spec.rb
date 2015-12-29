module WSDL
  RSpec.describe Property do
    let(:nillable) { nil }
    let(:max_occurance) { nil }
    subject(:property) { described_class.new('string', 'Order', nillable, max_occurance) }

    describe '#optional?' do
      subject { property.optional? }

      context 'when nillable is "true"' do
        let(:nillable) { 'true' }

        it('returns true') { expect(subject).to be(true) }
      end

      context 'when nillable is not "true"' do
        let(:nillable) { 'false' }

        it('returns false') { expect(subject).to be(false) }
      end
    end

    describe '#tokenized_type' do
      subject { property.tokenized_type }

      it 'returns type in tokenized form of language' do
        expect(subject).to eq('String')
      end
    end

    describe '#multivalued?' do
      subject { property.multivalued? }

      context 'when max_occurance is "unbounded"' do
        let(:max_occurance) { 'unbounded' }
        it('returns true') { expect(subject).to be(true) }
      end

      context 'when max_occurance is not "unbounded"' do
        let(:max_occurance) { '1' }
        it('returns false') { expect(subject).to be(false) }
      end
    end
  end
end
