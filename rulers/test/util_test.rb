# frozen_string_literal: true

require_relative "test_helper"

class UtilTest < Minitest::Test
  def test_to_underscore_for_normal_controller
    assert_equal Rulers.to_underscore("RulersController"), "rulers_controller"
  end

  def test_to_underscore_for_folders
    assert_equal Rulers.to_underscore("Test::RulersController"), "test/rulers_controller"
  end
end
