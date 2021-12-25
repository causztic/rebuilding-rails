class TestsController < Rulers::Controller
  def index
    "Hello!"
  end

  def instance_variable
    @variable = "test"
    render :instance_variable
  end
end
