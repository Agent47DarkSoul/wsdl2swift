require_relative 'render_context'
require_relative 'template'

module Swift
  module Renderer
    def self.render_template(template_name, type)
      context = RenderContext.new(type).bindings
      Template.new(template_name).render(context)
    end
  end
end
