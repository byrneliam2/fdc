# Liam Byrne (byrneliam2)
# fdc

require "test/unit"

require_relative "tc_parser"
require_relative "tc_generator_process"
require_relative "tc_closure"
require_relative "tc_minimal_cover"
require_relative "tc_normal_form"

# Cheeky monkey patch over setup and teardown methods to hide stdout
class Test::Unit::TestCase

  def setup
    @og_stdout = $stdout
    $stdout = File.new("NUL", 'w')
  end

  def teardown
    $stdout = @og_stdout
  end

end