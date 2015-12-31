require_relative 'class_writer'
require_relative 'renderer'

module Swift
  class Generator
    def initialize(output_path)
      @output_path = output_path
    end

    def generate(wsdl_file)
      wsdl_file.types.each do |type|
        generate_file_for(type)
      end
    end

    private

    def generate_file_for(type)
      code = Renderer.new('class').render(Code::Class.new(type))
      ClassWriter.new(type.name, code).write(@output_path)
    end
  end
end
