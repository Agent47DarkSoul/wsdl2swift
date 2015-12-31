module Swift
  class ClassWriter
    def initialize(name, code)
      @name = name
      @code = code
    end

    def write(output_path)
      File.open(path(output_path), 'w') do |file|
        file << @code
      end
    end

    private

    def path(output_path)
      Pathname.new(output_path) + "#{@name}.swift"
    end
  end
end
