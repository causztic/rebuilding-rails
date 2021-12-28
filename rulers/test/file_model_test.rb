# frozen_string_literal: true

require_relative "test_helper"

class FileModelTest < Minitest::Test
  def test_find_all_by_attribute
    Dir.chdir('test/app') do
      result = Rulers::Model::FileModel.find_all_by_submitter("tester")

      assert_equal result.length, 1
      assert_equal result[0].hash["submitter"], "tester"
      assert_equal result[0].hash["quote"], "A penny saved is a penny earned."
      assert_equal result[0].hash["attribution"], "Ben Franklin"
    end
  end

  def test_find_all_by_missing_attribute
    Dir.chdir('test/app') do
      assert_equal Rulers::Model::FileModel.find_all_by_quote("missing"), []
    end
  end
end
