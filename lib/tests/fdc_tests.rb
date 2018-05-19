# Liam Byrne (byrneliam2)
# fdc

require "test/unit"

require_relative "../io/parser"

class FDCTests < Test::Unit::TestCase

    def test01_parseSchemas
        p = FDCParser.new
        assert_true(p.assert_schema("R(A)"))
    end

    def test02_parseSchemas
        p = FDCParser.new
        assert_true(p.assert_schema("R(A, B,CD)"))
    end

    def test10_parseSchemas
        p = FDCParser.new
        assert_false(p.assert_schema("(A)"))
    end

    def test11_parseSchemas
        p = FDCParser.new
        assert_false(p.assert_schema("R(1, 2, 3)"))
    end

    def test12_parseFDs
        p = FDCParser.new
        assert_false(p.assert_fds("{AB}"))
    end

    def test13_parseFDs
        p = FDCParser.new
        assert_false(p.assert_fds("{A->B,C->D}"))
    end

end

