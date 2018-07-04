# Liam Byrne (byrneliam2)
# fdc

require "test/unit"

require_relative "tc_parser"

# fdc -c R(A,B,C,D) {A/B;C/D}
# fdc -c R(A,B,C,D,E) {A,B/C;C,D/E;D,E/B}
# fdc -m R(A,B,C,D,E) {A/B,C,D,E}
# fdc -m R(A,B,C,D,E) {A,B/C,D,E}

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