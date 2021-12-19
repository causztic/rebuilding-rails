# frozen_string_literal: true

require_relative "rulers/version"

module Rulers
  class Application
    def call(env)
      [200, {'Content-Type' => 'text/html'}, ["Hello World from Ruby on Rulers!"]]
    end
  end
end
