require_relative 'code/helpers'

module Swift
  class RenderContext
    include Code::Helpers

    def initialize(type)
      @type = type
    end

    def render(template_name, type)
      Renderer.new(template_name).render(type)
    end

    def bindings
      Kernel.binding
    end

    def method_missing(name, *args)
      @type.send(name, *args)
    end
  end
end
