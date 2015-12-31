require 'erb'
require_relative 'code/class'
require_relative 'render_context'

module Swift
  class Renderer
    def initialize(template_name)
      @template = template_name
    end

    def render(type)
      erb = ERB.new(template_contents, nil, '<>')
      erb.result(context(type))
    end

    private

    def context(type)
      RenderContext.new(type).bindings
    end

    def template_contents
      File.open(template_path).read
    end

    def template_path
      Wsdl2swift.root + "lib/swift/code_templates/#{@template}.erb"
    end
  end
end
