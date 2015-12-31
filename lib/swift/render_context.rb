require_relative 'code/helpers'

module Swift
  class RenderContext
    include Code::Helpers

    def initialize(object, accessible_by = nil)
      @object = object
      @accessible_by = accessible_by
    end

    def render(template_name, opts = {})
      inner_context_name, inner_context_object = opts.first

      context = self.class.new(inner_context_object, inner_context_name)
      Template.new(template_name, true).render(context.bindings)
    end

    def bindings
      Kernel.binding
    end

    def method_missing(name, *args)
      if @accessible_by
        if !respond_to?(name) && name == @accessible_by
          self.define_singleton_method(@accessible_by) { @object }
          send(name)
        else
          raise "undefined variable `#{name}`"
        end
      else
        @object.send(name, *args)
      end
    end
  end
end
