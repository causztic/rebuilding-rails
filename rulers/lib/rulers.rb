# frozen_string_literal: true

require "rulers/version"
require "rulers/routing"
require "rulers/util"
require "rulers/dependencies"
require "rulers/controller"
require "rulers/file_model"

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, { 'Content-Type' => 'text/html' }, []]
      end

      if env['PATH_INFO'] == '/'
        return [302, { 'Location' => '/quotes/a_quote' }, []]
      end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [200, {'Content-Type'=>'text/html'}, [text]]
    rescue StandardError => e
      [500, { 'Content-Type' => 'text/html' }, ["<div>#{e}</div>"]]
    end
  end
end
