require "erubis"
require "rulers/file_model"
module Rulers
  class Controller
    include Rulers::Model
    
    def initialize(env)
      @env = env
    end

    def env
      @env
    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub(/Controller$/, "")
      Rulers.to_underscore(klass)
    end

    # https://github.com/rails/rails/blob/main/actionview/lib/action_view/template/handlers/erb.rb
    # https://github.com/rails/rails/blob/main/actionview/lib/action_view/template/handlers/erb/erubis.rb
    def render(view_name, locals = {})
      # ruby 2.6.0
      # this loads instance variables set in the controller action into the template
      variables = instance_variables.to_h do |variable|
        [variable, instance_variable_get(variable)]
      end

      filename = File.join("app", "views", controller_name, "#{view_name}.html.erb")
      template = File.read(filename)

      eruby = Erubis::Eruby.new(template)
      eruby.result(locals.merge(variables))
    end
  end
end