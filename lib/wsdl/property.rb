module WSDL
  class Property < Struct.new(:type, :name, :nillable);
    include Inflections

    def tokenized_type
      classify(type)
    end

    def optional?
      nillable == 'true'
    end
  end
end
