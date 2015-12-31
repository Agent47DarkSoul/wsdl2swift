require 'erb'

module Swift
  class Renderer
    def initialize(type)
      @type = type
    end

    def render
      erb = ERB.new(File.open(Wsdl2swift.root + 'lib/swift/code_templates/class.erb').read)
      erb.result
    end
  end
end
