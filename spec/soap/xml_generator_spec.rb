require 'soap/xml_generator'

module SOAP
  RSpec.describe XMLGenerator do
    let(:wsdl_file) { WSDL::File.new(Wsdl2swift.root + 'tmp/excursion.wsdl') }
    subject(:generator) { described_class.new(wsdl_file) }

    describe '#generate_request' do
      subject { generator.generate_request('SearchAddonsOperationPORT') }

      it 'returns the xml structure for the message' do
        search_addons_body = Nokogiri::XML(
          open(Wsdl2swift.root + 'tmp/addons_request.xml')
        )

        expect(subject.to_xml).to eq(search_addons_body.to_xml)
      end
    end
  end
end
