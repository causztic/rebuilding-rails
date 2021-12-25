require_relative 'test_helper' # require but check from the current directory, not from $LOAD_PATH
require_relative 'app/controllers/tests_controller'

class TestApp < Rulers::Application
end

class RulersAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TestApp.new
  end

  def test_request
    get "/tests/index"
    
    assert last_response.ok?
    body = last_response.body
    assert body["Hello!"]
  end

  # FIXME: failing test due to view not loaded properly
  # def test_instance_variable
  #   get "/tests/instance_variable"

  #   assert last_response.ok?
  #   body = last_response.body
  #   assert body["test"]
  # end
end