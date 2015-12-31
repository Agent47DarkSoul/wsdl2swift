require 'erb'
require_relative 'code/class'

module Swift
  class Renderer
    def initialize(type)
      @type = type
    end

    def render
      erb = ERB.new(File.open(Wsdl2swift.root + 'lib/swift/code_templates/class.erb').read)
      erb.result(Code::Class.new(@type).bindings)
    end
  end
end
