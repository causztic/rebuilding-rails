module Rulers
  def self.to_underscore(string)
    string.gsub(/::/, '/')                       # 1. splits namespace, e.g. TTest::TestController => TTest/TestController
          .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2') # 2. splits multiple capital letters, e.g. TTest/TestController => T_Test/TestController
          .gsub(/([a-z\d])([A-Z])/, '\1_\2')     # 3. splits small letter + number following a capital letter, e.g. T_Test/Test1Controller => T_Test/Test1_Controller
          .tr('-', '_').downcase                 # 4. Converts all dashes to lowercase, and downcase
  end
end