require 'erb'

module Swift
  class Template
    def initialize(template_name, partial = false)
      @name = template_name
      @partial = partial
    end

    def render(context)
      erb = ERB.new(template_contents, nil, '<>')
      erb.result(context)
    end

    private

    def template_contents
      File.open(template_path).read
    end

    def template_path
      Wsdl2swift.root + "lib/swift/code_templates/#{name}.erb"
    end

    def name
      @partial ? "_#{@name}" : @name
    end
  end
end