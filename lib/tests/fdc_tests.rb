# Liam Byrne (byrneliam2)
# fdc

require "test/unit"

require_relative "../io/parser"

class FDCTests < Test::Unit::TestCase

    def test01_parse
        p = FDCParser.new
        assert_true(p.assert_schema("R(A)"))
    end

    def test02_parse
        p = FDCParser.new
        assert_false(p.assert_schema("(A)"))
    end

end

