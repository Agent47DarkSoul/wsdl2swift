require 'erb'
require_relative 'code/class'

module Swift
  class Renderer
    def initialize(type)
      @type = type
    end

    def render
      erb = ERB.new(class_file_code, nil, '<>')
      erb.result(Code::Class.new(@type).bindings)
    end

    private

    def class_file_code
      File.open(Wsdl2swift.root + 'lib/swift/code_templates/class.erb').read
    end
  end
end
