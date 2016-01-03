module WSDL
  class Property < Struct.new(:type, :name, :nillable, :max_occurance)
    include Inflections

    def tokenized_type
      classify(type)
    end

    def optional?
      nillable == 'true'
    end

    def multivalued?
      max_occurance == 'unbounded'
    end

    def inbuilt_type?
      ['String', 'Double', 'Integer', 'Boolean', 'DateTime'].include?(tokenized_type)
    end
  end
end
