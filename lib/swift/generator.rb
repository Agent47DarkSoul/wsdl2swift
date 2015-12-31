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
      rendered_class = Renderer.new(type).render
      ClassWriter.new(type.name, rendered_class).write(@output_path)
    end
  end
end
