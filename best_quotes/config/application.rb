require 'rulers'
$LOAD_PATH << File.join(__dir__, '..', 'app', 'controllers')

module BestQuotes
  class Application < Rulers::Application
  end
end